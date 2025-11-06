import 'dart:async';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_join_info_screen.controller.g.dart';

@riverpod
class OwnerJoinInfoScreenController extends _$OwnerJoinInfoScreenController {
  late FormGroup form;

  @override
  FutureOr<void> build() {
    _initializeForm();
  }

  void _initializeForm() {
    form = FormGroup({
      'storeName': FormControl<String>(validators: [Validators.required]),
      'postalCode': FormControl<String>(validators: [Validators.required]),
      'address': FormControl<String>(validators: [Validators.required]),
      'addressDetail': FormControl<String>(validators: [Validators.required]),
      'representativeName': FormControl<String>(
        validators: [Validators.required],
      ),
      'representativePhone': FormControl<String>(
        validators: [Validators.required],
      ),
      'businessNumber': FormControl<String>(validators: [Validators.required]),
      'bankName': FormControl<String>(validators: [Validators.required]),
      'accountNumber': FormControl<String>(validators: [Validators.required]),
    });
  }

  void updateAddress({required String postalCode, required String address}) {
    form.control('postalCode').value = postalCode;
    form.control('address').value = address;
  }

  Future<void> submit() async {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    state = const AsyncValue.loading();

    try {
      // TODO: API 호출
      final formValue = form.value;
      print('Form submitted: $formValue');

      // 성공 시
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void dispose() {
    form.dispose();
  }
}
