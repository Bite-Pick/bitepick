import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:kpostal/kpostal.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/data/constant/financial_institution.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.controller.dart';
import 'package:magambell/src/features/auth/presenation/owner/widgets/bank_list_bottomsheet.dart';
import 'package:magambell/src/features/goods/presentation/widgets/image_upload_section.dart';
import 'package:magambell/src/features/owner/prsentation/owner_home_screen.dart';
import 'package:magambell/src/features/owner/prsentation/widgets/owner_approved_view.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_bottomsheet.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:magambell/src/widgets/mg_select.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OwnerJoinInfoRoute extends GoRouteData {
  const OwnerJoinInfoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OwnerJoinInfoScreen();
  }
}

// TODO: placeholder 전체적으로 다듬어야함(정보의 예시로 변경)
class OwnerJoinInfoScreen extends ConsumerStatefulWidget {
  const OwnerJoinInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OwnerJoinInfoScreenState();
}

class _OwnerJoinInfoScreenState extends ConsumerState<OwnerJoinInfoScreen> {
  final mockFormData = {
    'storeName': '마감벨 테스트 매장',
    'postalCode': '12345',
    'address': '서울특별시 강남구 테헤란로 427',
    'addressDetail': '위워크타워 10층',
    'latitude': 37.5058,
    'longitude': 127.0516,
    'parkingDescription': '건물 지하 주차장 2시간 무료',
    'representativeName': '홍길동',
    'representativePhone': '01012345678',
    'businessNumber': '1234567890',
    'bankName': '004', // KB국민은행
    'accountNumber': '111222333444',
  };

  @override
  Widget build(BuildContext context) {
    // watch를 사용해서 state 변경 시 rebuild
    ref.watch(ownerJoinInfoScreenControllerProvider);

    final controller = ref.read(ownerJoinInfoScreenControllerProvider.notifier);
    final form = controller.form;

    return ReactiveForm(
      formGroup: form,
      child: BaseScaffold(
        appBar: BaseAppBar(
          // action: TextButton(
          //   onPressed: () => controller.fillWithMockData(mockFormData),
          //   child: const Text('임시완성'),
          // ),
        ),
        backgroundColor: MgColorScheme.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildStoreInfoSection().margin(horizontal: MgSizes.xl),
                    Divider(thickness: MgSizes.size6).margin(top: MgSizes.xxxl),
                    _buildOwnerInfoSection().margin(horizontal: MgSizes.xl),
                  ],
                ),
              ),
            ),
            // 확인 버튼
            MgButton(
              onPressed: () async {
                final result = await controller.submit();
                if (result && context.mounted) {
                  DefaultRoute().go(context);
                }
              },
              content: const Text('확인'),
            ).primary().margin(
              horizontal: MgSizes.md,
              bottom: MgSizes.xxl,
              top: MgSizes.md,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreInfoSection() {
    final controller = ref.read(ownerJoinInfoScreenControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. 매장 이름
        _buildSectionTitle('매장 이름', subtitle: '체인점일 경우, 지점명까지 해주세요'),
        Gaps.h8,
        MgReactiveTextField(formControlName: 'storeName', hintText: '매장 이름 '),

        // 2. 매장 주소
        _buildSectionTitle('매장 주소'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MgReactiveTextField(
                formControlName: 'postalCode',
                hintText: '우편번호',
                enabled: false,
              ),
            ),
            Gaps.w8,
            MgButton(
              onPressed: _findPostalCode,
              content: const Text('주소 찾기').bold(),
              borderRadius: MgRadius.md,
              borderColor: MgColorScheme.gray1,
              backgroundColor: MgColorScheme.white,
              textColor: MgColorScheme.text,
            ),
          ],
        ),
        MgReactiveTextField(
          formControlName: 'address',
          hintText: '주소',
          enabled: false,
        ),
        MgReactiveTextField(
          formControlName: 'addressDetail',
          hintText: '상세주소 ',
        ),

        _buildSectionTitle("주차안내"),
        MgReactiveTextField(formControlName: 'parkingDescription'),

        _buildSectionTitle("대표 이미지"),
        ImageUploadSection(
          images: controller.localImages,
          onAddImages: controller.addLocalImages,
          onRemoveImage: controller.removeImage,
        ),
      ],
    );
  }

  Widget _buildOwnerInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3. 대표자 정보
        _buildSectionTitle('대표자 정보'),
        MgReactiveTextField(
          formControlName: 'representativeName',
          hintText: '대표자 성함 ',
        ),
        MgReactiveTextField(
          formControlName: 'representativePhone',
          hintText: '전화번호 (예: 01012345678)',
          keyboardType: TextInputType.phone,
        ),

        // 4. 사업자 등록 번호
        _buildSectionTitle('사업자 등록 번호'),
        MgReactiveTextField(
          formControlName: 'businessNumber',
          hintText: '"-" 제외한 10자리 숫자 ',
          keyboardType: TextInputType.number,
        ),

        // 5. 계좌 등록
        _buildSectionTitle('계좌 등록'),
        MgSelect<String?>(
          formControlName: 'bankName',
          hintText: '은행 선택',
          bottomSheetTitle: '은행 선택해주세요',
          options: financialInstitutions.values
              .map((e) => MgSelectOption(value: e.shortName, label: e.name))
              .toList(),
          customBottomSheet: _showBankBottomSheet,
        ),
        Gaps.h8,
        MgReactiveTextField(
          formControlName: 'accountNumber',
          hintText: '"-" 제외한 계좌번호 ',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title).md().bold(),
        if (subtitle != null) ...[
          Gaps.h2,
          Text(subtitle).sm().textGray().regular(),
        ],
      ],
    ).margin(top: MgSizes.xl, bottom: MgSizes.xs);
  }

  void _findPostalCode() async {
    final controller = ref.read(ownerJoinInfoScreenControllerProvider.notifier);

    await Navigator.push<Kpostal>(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          //javascripKey: 활성화시 주소가 선택되지 않는 이슈로, 직접 kakao api 호출
          callback: (Kpostal result) async {
            double? latitude;
            double? longitude;

            final latLng = await controller.geocodeWithKakao(result.address);
            latitude = latLng?.lat;
            longitude = latLng?.lng;

            if ((latitude == null || longitude == null) && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('위치 정보를 가져올 수 없습니다. 주소는 저장되었습니다.'),
                  duration: Duration(seconds: 3),
                ),
              );
            }

            controller.updateAddress(
              postalCode: result.postCode,
              address: result.address,
              latitude: latitude,
              longitude: longitude,
            );
          },
        ),
      ),
    );
  }

  void _showBankBottomSheet(
    BuildContext context,
    ReactiveFormFieldState<String?, String?> field,
    List<MgSelectOption<String?>> options,
  ) {
    MgBottomsheet.show(context, (context, bottomState) {
      return BankListBottomsheet(field: field);
    }, height: 300);
  }
}
