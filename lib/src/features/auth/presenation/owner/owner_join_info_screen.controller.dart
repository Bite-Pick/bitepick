import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/image_upload_response.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_join_info_screen.controller.g.dart';

@Riverpod(keepAlive: true)
class OwnerJoinInfoScreenController extends _$OwnerJoinInfoScreenController {
  late FormGroup form;
  List<LocalImage> localImages = [];

  @override
  FutureOr<void> build() {
    _initializeForm();
  }

  void _initializeForm() {
    form = FormGroup({
      'storeName': FormControl<String>(
        validators: [Validators.required, Validators.minLength(1)],
      ),
      'postalCode': FormControl<String>(validators: [Validators.required]),
      'address': FormControl<String>(validators: [Validators.required]),
      'addressDetail': FormControl<String>(validators: [Validators.required]),
      'latitude': FormControl<double>(),
      'longitude': FormControl<double>(),
      'images': FormControl<int>(value: 0),
      'parkingDescription': FormControl<String>(),

      'representativeName': FormControl<String>(
        validators: [Validators.required, Validators.minLength(1)],
      ),
      'representativePhone': FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(r'^01[0-9]-?[0-9]{3,4}-?[0-9]{4}$'),
        ],
      ),
      'businessNumber': FormControl<String>(
        validators: [Validators.required, Validators.pattern(r'^\d{10}$')],
      ),
      'bankName': FormControl<String>(validators: [Validators.required]),
      'accountNumber': FormControl<String>(
        validators: [Validators.required, Validators.pattern(r'^\d+$')],
      ),
    });
  }

  // 로컬 이미지 추가
  void addLocalImages(List<File> files) {
    final newImages = <LocalImage>[];
    var currentId = localImages.length;

    for (final file in files) {
      final fileName = file.path.split('/').last;
      newImages.add(LocalImage(id: currentId, key: fileName, file: file));
      currentId++;
    }

    localImages = [...localImages, ...newImages];
    // Form에 이미지 개수 업데이트
    form.control('images').value = localImages.length;
    // Rebuild the UI by putting the controller in a loading state and then back to data
    state = const AsyncLoading();
    state = const AsyncData(null);
  }

  void fillWithMockData(Map<String, Object> data) {
    form.patchValue(data);
  }

  // 이미지 제거
  void removeImage(int index) {
    if (index >= 0 && index < localImages.length) {
      localImages.removeAt(index);
      // Form에 이미지 개수 업데이트
      form.control('images').value = localImages.length;
      // Rebuild the UI
      state = const AsyncLoading();
      state = const AsyncData(null);
    }
  }

  void updateAddress({
    required String postalCode,
    required String address,
    double? latitude,
    double? longitude,
  }) {
    form.control('postalCode').value = postalCode;
    form.control('address').value = address;

    // latitude, longitude를 저장할 FormControl 추가
    if (latitude != null) {
      form.control('latitude').value = latitude;
    }
    if (longitude != null) {
      form.control('longitude').value = longitude;
    }
  }

  Future<bool> submit() async {
    if (!form.valid) {
      form.markAllAsTouched();

      // 각 필드의 에러 출력
      form.controls.forEach((key, control) {
        if (control.invalid) {
          talker.debug('[$key] errors: ${control.errors}');
        }
      });

      return false;
    }

    state = const AsyncValue.loading();

    try {
      final formValue = form.value;
      talker.debug(formValue);

      final fullAddress =
          '${formValue['address']} ${formValue['addressDetail']}'.trim();

      // FormControl에 저장된 위도/경도 가져오기 (KpostalView에서 받은 값)
      final latitude = formValue['latitude'] as double?;
      final longitude = formValue['longitude'] as double?;

      // // 위경도 검증: null이거나 둘 다 0.0인 경우 경고
      // if (latitude == null || longitude == null)
      //   throw Exception('위치 정보가 없습니다. 주소 찾기를 다시 시도해주세요.');

      // TODO: 이미지 업로드 구현
      final imageUploads = localImages.mapIndexed((index, localImage) {
        // This is where you would handle file upload and get back a key or URL
        // For now, we'll just use the local file name as a placeholder key.
        return {'key': localImage.key, 'id': index + 1};
      }).toList();

      // final result = await ref
      //     .read(storeRepositoryProvider)
      //     .createStore(
      //       name: formValue['storeName'] as String,
      //       address: fullAddress,
      //       latitude: latitude ?? 0,
      //       longitude: longitude ?? 0,
      //       ownerName: formValue['representativeName'] as String,
      //       ownerPhone: formValue['representativePhone'] as String,
      //       businessNumber: formValue['businessNumber'] as String,
      //       bankName: formValue['bankName'] as String,
      //       bankAccount: formValue['accountNumber'] as String,
      //       storeImagesRegisters: imageUploads,
      //       // parkingDescription:formValue['parkingDescription'] as String // TODO: 추가 예정
      //     );
      final result = [
        PresignedUrlImage(
          name:
              "image_picker_41F170AA-95F4-41F8-8406-76701925B2E0-66107-000008377C733662.jpg",
          url:
              "https://magambell-dev-s3.s3.ap-northeast-2.amazonaws.com/STORE/OWNER/776169077802262953/1_image_picker_41F170AA-95F4-41F8-8406-76701925B2E0-66107-000008377C733662.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20251111T195759Z&X-Amz-SignedHeaders=host&X-Amz-Expires=299&X-Amz-Credential=AKIA5PAVYLE7CKRXHU7G%2F20251111%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=4da8411638b84689fe77820e5d797a0311cbc42379781a22e7939b1e3ef36e0d",
        ),
        PresignedUrlImage(
          name:
              "image_picker_B6D29A25-2238-46D9-9148-4F2180660447-66107-000008377C45A6A8.jpg",
          url:
              "https://magambell-dev-s3.s3.ap-northeast-2.amazonaws.com/STORE/OWNER/776169077802262953/2_image_picker_B6D29A25-2238-46D9-9148-4F2180660447-66107-000008377C45A6A8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20251111T195759Z&X-Amz-SignedHeaders=host&X-Amz-Expires=299&X-Amz-Credential=AKIA5PAVYLE7CKRXHU7G%2F20251111%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=f181037ab5bd266cfccf89f1af2026b742b8f6fbb3143d1c254fc8b242cdb17c",
        ),
      ];
      await ref
          .read(presignedImageRepositoryProvider)
          .uploadImagesToS3(
            localImages: localImages,
            presignedUrls: result,
            onProgress: (currentIndex, total, sent, totalBytes) {
              final fileProgress = totalBytes > 0 ? sent / totalBytes : 0;
              final overallProgress = (currentIndex + fileProgress) / total;
              print("업로드 완료");
              // state = state.copyWith(uploadProgress: overallProgress);
            },
          );

      // 성공 시
      state = const AsyncValue.data(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  void dispose() {
    form.dispose();
  }
}
