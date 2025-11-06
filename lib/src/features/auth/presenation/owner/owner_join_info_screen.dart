import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/auth/data/constant/financial_institution.dart';
import 'package:magambell/src/features/auth/presenation/owner/owner_join_info_screen.controller.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
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
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(ownerJoinInfoScreenControllerProvider.notifier);
    final form = controller.form;

    return ReactiveForm(
      formGroup: form,
      child: BaseScaffold(
        appBar: BaseAppBar(),
        backgroundColor: MgColorScheme.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. 매장 이름
                    _buildSectionTitle(
                      '매장 이름',
                      subtitle: '체인점일 경우, 지점명까지 해주세요',
                    ),
                    Gaps.h8,
                    MgReactiveTextField(
                      formControlName: 'storeName',
                      hintText: '매장 이름 ',
                    ),

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

                    // 3. 대표자 정보
                    _buildSectionTitle('대표자 정보'),
                    MgReactiveTextField(
                      formControlName: 'representativeName',
                      hintText: '대표님 성함 ',
                    ),
                    MgReactiveTextField(
                      formControlName: 'representativePhone',
                      hintText: '대표님 연락처 ',
                      keyboardType: TextInputType.phone,
                    ),

                    // 4. 사업자 등록 번호
                    _buildSectionTitle('사업자 등록 번호'),
                    MgReactiveTextField(
                      formControlName: 'businessNumber',
                      hintText: '사업자 등록 번호 ',
                      keyboardType: TextInputType.number,
                    ),

                    // 5. 계좌 등록
                    _buildSectionTitle('계좌 등록'),
                    // TODO:
                    MgSelect<String?>(
                      formControlName: 'bankName',
                      hintText: '은행 선택',
                      options: const [
                        MgSelectOption(value: 'KB', label: 'KB국민은행'),
                        MgSelectOption(value: 'SHINHAN', label: '신한은행'),
                        MgSelectOption(value: 'WOORI', label: '우리은행'),
                        MgSelectOption(value: 'HANA', label: '하나은행'),
                        MgSelectOption(value: 'NH', label: 'NH농협은행'),
                        MgSelectOption(value: 'IBK', label: 'IBK기업은행'),
                        MgSelectOption(value: 'KBANK', label: '케이뱅크'),
                        MgSelectOption(value: 'KAKAO', label: '카카오뱅크'),
                        MgSelectOption(value: 'TOSS', label: '토스뱅크'),
                      ],
                    ),
                    Gaps.h8,
                    MgReactiveTextField(
                      formControlName: 'accountNumber',
                      hintText: '계좌번호 ',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ).margin(horizontal: MgSizes.xl),
              ),
            ),
            // 확인 버튼
            MgButton(
              onPressed: () => controller.submit(),
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

  void _findPostalCode() {
    final controller = ref.read(ownerJoinInfoScreenControllerProvider.notifier);
    // TODO: 주소 찾기 API 연동 (Daum 우편번호 서비스 등)
    // 예시:
    // controller.updateAddress(
    //   postalCode: '12345',
    //   address: '서울특별시 강남구 테헤란로',
    // );
    print('주소 찾기');
  }
}
