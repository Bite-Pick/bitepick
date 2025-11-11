import 'dart:async';

import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_join_info_screen.controller.g.dart';

@Riverpod(keepAlive: true)
class OwnerJoinInfoScreenController extends _$OwnerJoinInfoScreenController {
  late FormGroup form;

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
          print('[$key] errors: ${control.errors}');
        }
      });

      return false;
    }

    state = const AsyncValue.loading();

    try {
      final formValue = form.value;
      print(formValue);

      final fullAddress =
          '${formValue['address']} ${formValue['addressDetail']}'.trim();

      // FormControl에 저장된 위도/경도 가져오기 (KpostalView에서 받은 값)
      final latitude = formValue['latitude'] as double?;
      final longitude = formValue['longitude'] as double?;

      // // 위경도 검증: null이거나 둘 다 0.0인 경우 경고
      // if (latitude == null || longitude == null)
      //   throw Exception('위치 정보가 없습니다. 주소 찾기를 다시 시도해주세요.');

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
            storeImagesRegisters: null, // TODO: 이미지 업로드 구현
            // parkingDescription:formValue['parkingDescription'] as String // TODO: 추가 예정
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
