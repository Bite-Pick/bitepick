import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/features/admin/data/dtos/registered_store.dto.dart';
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

class AdminRegisteredStoreDetailExtra {
  const AdminRegisteredStoreDetailExtra({required this.registeredStore});
  final RegisteredStoreDto registeredStore;
}

class AdminRegisteredStoreDetailRoute extends GoRouteData {
  const AdminRegisteredStoreDetailRoute({required this.$extra});
  final AdminRegisteredStoreDetailExtra $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminRegisteredStoreDetailScreen(store: $extra.registeredStore);
  }
}

class AdminRegisteredStoreDetailScreen extends ConsumerStatefulWidget {
  const AdminRegisteredStoreDetailScreen({required this.store, super.key});
  final RegisteredStoreDto store;

  @override
  ConsumerState<AdminRegisteredStoreDetailScreen> createState() =>
      _AdminRegisteredStoreDetailScreenState();
}

class _AdminRegisteredStoreDetailScreenState
    extends ConsumerState<AdminRegisteredStoreDetailScreen>
  with FormSectionBuilderMixin {
  late FormGroup form;
  List<String> localImages = [];

  @override
  void initState() {
    super.initState();
    _initializeForm();
    localImages = widget.store.imageUrl;
  }
  
  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: BaseScaffold(
        appBar: const BaseAppBar(title: Text("입점 매장 정보 수정")),
        backgroundColor: MgColorScheme.gray11,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildStoreInfoSection().margin(horizontal: MgSizes.xl),
                    Divider(thickness: MgSizes.size6).margin(top: MgSizes.xxxl),
                    const OwnerInfoSection(
                      enabled: false, // 읽기 전용
                    ).margin(horizontal: MgSizes.xl),
                    
                    Divider(thickness: MgSizes.size6).margin(top: MgSizes.xxxl),
                    _buildStoreGoodsInfoSection().margin(horizontal: MgSizes.xl),
                  ],
                ),
              ),
            ),
            // 수정 완료 버튼
            MgButton(
              onPressed: _handleEdit, 
              content: const Text('수정 완료'),
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
        MgReactiveTextField(formControlName: 'storeName', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("매장 설명"),
        MgReactiveTextField(formControlName: 'description', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("매장 주소"),
        MgReactiveTextField(formControlName: 'address', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("주차 안내"),
        MgReactiveTextField(formControlName: 'parkingDescription', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("대표 이미지"),
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
        MgReactiveTextField(formControlName: 'pickupTime', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("판매 개수"),
        MgReactiveTextField(formControlName: 'quantity', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("정가"),
        MgReactiveTextField(formControlName: 'originPrice', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("할인율"),
        MgReactiveTextField(formControlName: 'discount', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("상품 정보"),
        // TODO: 이미지 수정 기능 추가(+다중 이미지 처리 관련 서버 수정)
        widget.store.goodsImages.isNotEmpty
            ? Row(
                children: widget.store.goodsImages
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
    ); // 상품 이미지 및 정보 표시
  }

  void _initializeForm() {
    final store = widget.store;
    form = FormGroup({
      'storeName': FormControl<String>(
        value: store.storeName,
        validators: [Validators.required],
      ),
      'description': FormControl<String>(
        value: '',
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
      'quantity': FormControl<String>(
        value: store.quantity.toString(),
        validators: [Validators.required],
      ),
      'originPrice': FormControl<String>(
        value: store.originPrice.toString(),
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

  void _handleEdit() {
    showDialog(
      context: context,
      builder: (dialogContext) => MgAlertDialog.basic(
        title: '수정을 완료하시겠습니까?',
        content: const Text(''),
        confirmText: '수정 완료',
        onConfirm: () async => _manageStore(int.parse(widget.store.storeId)),
      ),
    );
  }

  /// 입점 매장 정보 수정
  Future<void> _manageStore(int storeId) async {
    final res = await ref.read(adminRepositoryProvider).manageStore(
      storeId,
      storeName: form.control('storeName').value as String,
      address: form.control('address').value as String,
      latitude: widget.store.latitude,
      longitude: widget.store.longitude,
      ownerName: form.control('representativeName').value as String,
      ownerPhone: form.control('representativePhone').value as String,
      businessNumber: form.control('businessNumber').value as String,
      bankName: form.control('bankName').value as String,
      bankAccount: form.control('accountNumber').value as String,
      description: form.control('description').value as String,
      parkingDescription: form.control('parkingDescription').value as String,
      storeImages: [],
      goodsName: form.control('goodsName').value as String,
      startTime: widget.store.startTime,
      endTime: widget.store.endTime,
      originalPrice: int.parse(form.control('originPrice').value as String),
      salePrice: widget.store.salePrice,
      discount: int.parse(
        (form.control('discount').value as String).replaceAll('%', ''),
      ),
      quantity: int.parse(form.control('quantity').value as String),
      saleStatus: widget.store.saleStatus,
      goodsImages: [],
    );

    // 로딩 다이얼로그 닫기
    if (res && mounted) {
      context.pop();
      ToastPresentor.success(context, '수정이 완료되었습니다');
      ref.invalidate(pendingStoreListProvider);
    } else {
      ToastPresentor.error(context, '수정이 완료되지 않았습니다');
    }
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }
}
