import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
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
      'addressDetail': FormControl<String>(),
      'latitude': FormControl<double>(),
      'longitude': FormControl<double>(),
      'images': FormControl<int>(value: 0),
      'parkingDescription': FormControl<String>(), // TODO: 필수..?

      'representativeName': FormControl<String>(
        validators: [Validators.required, Validators.minLength(1)],
      ),
      'representativePhone': FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(r'^01[0-9][0-9]{7,8}$'), // 숫자만 10-11자리
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
    talker.info('[Image] Adding ${files.length} images');
    final newImages = <LocalImage>[];
    var currentId = localImages.length;

    for (final file in files) {
      final fileName = file.path.split('/').last;
      newImages.add(LocalImage(id: currentId, key: fileName, file: file));
      talker.debug('[Image] Added image #$currentId: $fileName');
      currentId++;
    }

    localImages = [...localImages, ...newImages];
    talker.info('[Image] Total images: ${localImages.length}');

    // Form에 이미지 개수 업데이트
    form.control('images').value = localImages.length;

    // IMPORTANT: state를 업데이트해야 UI가 rebuild됨
    state = AsyncValue.data(null);
    talker.debug('[Image] UI state updated');
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
      final invalidFields = form.controls.entries
          .where((entry) => entry.value.invalid)
          .map((entry) => entry.key)
          .join(', ');

      if (invalidFields.isNotEmpty) {
        talker.debug('다음 항목을 확인해주세요 : $invalidFields');
      }

      return false;
    }

    state = const AsyncValue.loading();

    try {
      final formValue = form.value;
      talker.debug(formValue);

      final fullAddress =
          '${formValue['address']} ${formValue['addressDetail'] ?? ""}'.trim();

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
        return {'key': localImage.key, 'id': index + 1}; // TODO: id 규칙 만들기
      }).toList();
      if (imageUploads.isEmpty) {
        talker.debug("이미지는 최소 1장이상 업로드해주세요");
        return false;
      }

      talker.info('[Store] Creating store with ${imageUploads.length} images');

      final result = await ref
          .read(storeRepositoryProvider)
          .createStore(
            name: formValue['storeName'] as String,
            address: fullAddress,
            latitude: latitude ?? 0,
            longitude: longitude ?? 0,
            ownerName: formValue['representativeName'] as String,
            ownerPhone: formValue['representativePhone'] as String,
            businessNumber: formValue['businessNumber'] as String,
            bankName: formValue['bankName'] as String,
            bankAccount: formValue['accountNumber'] as String,
            storeImagesRegisters: imageUploads,
            // parkingDescription:formValue['parkingDescription'] as String // TODO: 추가 예정
          );

      talker.info('[S3] Starting upload for ${localImages.length} images');
      talker.debug('[S3] Presigned URLs count: ${result.length}');
      if (result.isEmpty) return false;
      bool isSuccess = false;
      await ref
          .read(presignedImageRepositoryProvider)
          .uploadImagesToS3(
            localImages: localImages,
            presignedUrls: result,
            onProgress: (currentIndex, total, sent, totalBytes) {
              final fileProgress = totalBytes > 0 ? sent / totalBytes : 0;
              final overallProgress = (currentIndex + fileProgress) / total;
              talker.info(
                '[S3] Upload progress: ${(overallProgress * 100).toStringAsFixed(1)}% ($currentIndex/$total)',
              );
              isSuccess = true;
            },
          );

      talker.info('[S3] Upload completed successfully');

      // 성공 시
      state = const AsyncValue.data(null);
      return isSuccess;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }

  Future<LatLng?> geocodeWithKakao(String query) async {
    final restApiKey = Environment.kakaoRestApiKey;
    final dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': 'KakaoAK $restApiKey',
          "KA": "sdk/1.0 flutter os/ios-17.0 lang/ko-KR",
        },
      ),
    );
    try {
      final res = await dio.get(
        'https://dapi.kakao.com/v2/local/search/address.json',
        queryParameters: {'query': query},
      );

      // Kakao 응답 구조는 항상 Map
      if (res.statusCode != 200 || res.data == null) {
        talker.warning('카카오 지오코딩 실패: ${res.statusCode} ${res.data}');
        return null;
      }

      final data = res.data as Map<String, dynamic>;
      final docs = data['documents'] as List<dynamic>;

      if (docs.isEmpty) {
        talker.debug('카카오 지오코딩: 결과 없음 ($query)');
        return null;
      }

      final first = docs.first as Map<String, dynamic>;

      final x = double.tryParse(first['x']?.toString() ?? '');
      final y = double.tryParse(first['y']?.toString() ?? '');

      if (x == null || y == null) {
        talker.warning('카카오 지오코딩: 좌표 파싱 실패 ($query) → $first');
        return null;
      }

      return LatLng(y, x); // Kakao: y=lat, x=lng
    } catch (e, st) {
      talker.error('카카오 지오코딩 오류', e, st);
      return null;
    }
  }

  void dispose() {
    form.dispose();
  }
}

class LatLng {
  final double lat;
  final double lng;

  LatLng(this.lat, this.lng);
}
