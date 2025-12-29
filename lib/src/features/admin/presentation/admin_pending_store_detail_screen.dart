import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/admin/data/dtos/pending_store.dto.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/auth/presenation/owner/widgets/owner_info_section.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/mg_alert_dialog.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:magambell/src/widgets/mixins/form_section_builder_mixin.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminPendingStoreDetailExtra {
  const AdminPendingStoreDetailExtra({required this.pendingStore});
  final PendingStoreDto pendingStore;
}

class AdminPendingStoreDetailRoute extends GoRouteData {
  const AdminPendingStoreDetailRoute({required this.$extra});
  final AdminPendingStoreDetailExtra $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminPendingStoreDetailScreen(store: $extra.pendingStore);
  }
}

class AdminPendingStoreDetailScreen extends ConsumerStatefulWidget {
  const AdminPendingStoreDetailScreen({required this.store, super.key});
  final PendingStoreDto store;

  @override
  ConsumerState<AdminPendingStoreDetailScreen> createState() =>
      _AdminPendingStoreDetailScreenState();
}

class _AdminPendingStoreDetailScreenState
    extends ConsumerState<AdminPendingStoreDetailScreen>
    with FormSectionBuilderMixin {
  late FormGroup form;
  List<String> localImages = [];

  @override
  void initState() {
    super.initState();
    _initializeForm();
    // Initialize localImages from the store DTO
    localImages = widget.store.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: BaseScaffold(
        appBar: const BaseAppBar(title: Text("가입매장 검토")),
        backgroundColor: MgColorScheme.gray11,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildStoreInfoSection().margin(horizontal: MgSizes.xl),
                    Divider(thickness: MgSizes.size6).margin(top: MgSizes.xxxl),
                    _buildStoreGoodsInfoSection().margin(
                      horizontal: MgSizes.xl,
                    ),
                    Divider(thickness: MgSizes.size6).margin(top: MgSizes.xxxl),
                    const OwnerInfoSection(
                      enabled: false, // 읽기 전용
                    ).margin(horizontal: MgSizes.xl),
                  ],
                ),
              ),
            ),
            // 승인/거절 버튼
            MgButton(
              onPressed: _handleApprove,
              content: const Text('승인'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle("매장 이름"),
        MgReactiveTextField(formControlName: 'storeName', enabled: false),
        buildSectionTitle("매장주소"),
        MgReactiveTextField(formControlName: 'address', enabled: false),
        // buildSectionTitle("주차안내"),
        // MgReactiveTextField(
        //   formControlName: 'parkingDescription',
        //   enabled: false,
        // ),
        buildSectionTitle("대표이미지"),
        // TODO: 이미지 수정 기능 추가(+다중 이미지 처리 관련 서버 수정)
        widget.store.imageUrl.isNotEmpty
            ? Row(
                children: widget.store.imageUrl
                    .map(
                      (url) => BaseNetworkImage(
                        imageUrl: url,
                        width: 80.w,
                        height: 80.w,
                      ).margin(right: MgSizes.xs),
                    )
                    .toList(),
              )
            : const Text('등록된 이미지가 없습니다.'),
      ],
    );
  }

  Widget _buildStoreGoodsInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle("픽업 시간"),
        MgReactiveTextField(formControlName: 'pickupTime', enabled: false),
        buildSectionTitle("판매 개수"),
        MgReactiveTextField(formControlName: 'quantity', enabled: false),
        buildSectionTitle("정가"),
        MgReactiveTextField(formControlName: 'originPrice', enabled: false),
        buildSectionTitle("할인율"),
        MgReactiveTextField(formControlName: 'discount', enabled: false),
      ],
    ); // 상품 이미지 및 정보 표시
  }

  void _initializeForm() {
    final store = widget.store;
    form = FormGroup({
      'storeName': FormControl<String>(
        value: store.storeName,
        validators: [Validators.required],
      ),
      'address': FormControl<String>(
        value: store.address,
        validators: [Validators.required],
      ),
      'pickupTime': FormControl<String>(
        value:
            "${store.startTime.convertTime()} ~ ${store.endTime.convertTime()}",
        validators: [Validators.required],
      ),
      'quantity': FormControl<int>(
        value: store.quantity,
        validators: [Validators.required],
      ),
      'originPrice': FormControl<int>(
        value: store.originPrice,
        validators: [Validators.required],
      ),
      'discount': FormControl<String>(
        value: '${store.discount}%',
        validators: [Validators.required],
      ),
      'parkingDescription': FormControl<String>(
        value: '', // TODO: 서버 수정 필요!!
      ),
      'representativeName': FormControl<String>(
        value: store.ownerName,
        validators: [Validators.required],
      ),
      'representativePhone': FormControl<String>(
        value: store.ownerPhone,
        validators: [Validators.required],
      ),
      'businessNumber': FormControl<String>(
        value: store.businessNumber,
        validators: [Validators.required, Validators.minLength(10)],
      ),
      'bankName': FormControl<String?>(
        value: store.bankName,
        validators: [Validators.required],
      ),
      'accountNumber': FormControl<String>(
        value: store.bankAccount,
        validators: [Validators.required],
      ),
    });
  }

  void _handleApprove() {
    showDialog(
      context: context,
      builder: (dialogContext) => MgAlertDialog.basic(
        title: '가게를 승인하시겠습니까?',
        content: const Text('승인 시 가게에서 판매 등록이 가능합니다.'),
        confirmText: '승인',
        onConfirm: () async => _approveStore(widget.store.storeId),
      ),
    );
  }

  /// 매장 승인 처리
  Future<void> _approveStore(String storeId) async {
    final res = await ref.read(adminRepositoryProvider).approveStore(storeId);

    // 로딩 다이얼로그 닫기
    if (res && mounted) {
      context.pop();
      ToastPresentor.success(context, '매장이 승인되었습니다');
      ref.invalidate(pendingStoreListProvider);
    } else {
      ToastPresentor.error(context, '매장 승인이 실패하였습니다');
    }
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }
}
