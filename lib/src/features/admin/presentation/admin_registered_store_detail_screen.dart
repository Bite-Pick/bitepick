import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/admin/data/dtos/registered_store.dto.dart';
import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
import 'package:magambell/src/features/auth/presenation/owner/widgets/owner_info_section.dart';
import 'package:magambell/src/features/goods/domain/entities/goods_detail_item.dart';
import 'package:magambell/src/features/goods/presentation/widgets/goods_detail_info_form_item.dart';
import 'package:magambell/src/features/image/data/repositories/presigned_image_repository.dart';
import 'package:magambell/src/features/image/domain/entities/local_image.dart';
import 'package:magambell/src/features/image/utils/image_requester.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
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

  static const int _maxStoreImages = 5;

  late double _latitude;
  late double _longitude;

  // 대표 이미지: 기존 URL + 새 로컬 파일을 통합 관리
  // uploadedUrl != null → 기존 서버 이미지 / file != null → 새로 추가한 로컬 이미지
  final List<LocalImage> _storeImages = [];

  // 상품 정보 이미지
  final List<GoodsDetailItem> _goodsDetails = [];

  @override
  void initState() {
    super.initState();
    _latitude = widget.store.latitude;
    _longitude = widget.store.longitude;
    _initializeForm();
    // 기존 서버 이미지를 LocalImage(uploadedUrl)로 변환하여 통합 리스트에 추가
    for (var i = 0; i < widget.store.storeImages.length; i++) {
      _storeImages.add(LocalImage(
        id: i + 1,
        key: '',
        uploadedUrl: widget.store.storeImages[i],
      ));
    }
    // 기존 상품 이미지를 GoodsDetailItem으로 변환하여 추가
    for (final item in widget.store.goodsImageList) {
      if (item.imageUrl == null || item.imageUrl!.isEmpty) continue;
      _goodsDetails.add(GoodsDetailItem(
        localImage: LocalImage(
          id: _goodsDetails.length + 1,
          key: item.key,
          uploadedUrl: item.imageUrl,
        ),
        name: item.goodsName ?? '',
      ));
    }
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
                      enabled: false,
                    ).margin(horizontal: MgSizes.xl),
                    Divider(thickness: MgSizes.size6).margin(top: MgSizes.xxxl),
                    _buildStoreGoodsInfoSection().margin(horizontal: MgSizes.xl),
                  ],
                ),
              ),
            ),
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

  // ─── 대표 이미지 섹션 ───────────────────────────────────────────────────────

  Widget _buildStoreInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle("매장 이름"),
        MgReactiveTextField(formControlName: 'storeName', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("매장 설명"),
        MgReactiveTextField(formControlName: 'description', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("매장 주소"),
        GestureDetector(
          onTap: _findAddress,
          child: AbsorbPointer(
            child: MgReactiveTextField(formControlName: 'address', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
          ),
        ),
        buildSectionTitle("주차 안내"),
        MgReactiveTextField(formControlName: 'parkingDescription', enabled: true, compact: true, backgroundColor: MgColorScheme.gray9),
        buildSectionTitle("대표 이미지"),
        _buildStoreImageList(),
      ],
    );
  }

  Widget _buildStoreImageList() {
    final canAddMore = _storeImages.length < _maxStoreImages;

    if (_storeImages.isEmpty) {
      return GestureDetector(
        onTap: _pickStoreImages,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(MgRadius.md),
          ),
          child: MgButton(
            onPressed: _pickStoreImages,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseSvgIcon.camera(color: MgColorScheme.gray4),
                Gaps.w8,
                Text(
                  "사진추가(0/$_maxStoreImages)",
                ).textColor(MgColorScheme.gray4).regular(),
              ],
            ),
          ).gray(),
        ),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _storeImages.length + (canAddMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == 0 && canAddMore) {
            return _buildAddImageButton();
          }
          final imageIndex = canAddMore ? index - 1 : index;
          return _buildStoreImageItem(imageIndex);
        },
      ),
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: _pickStoreImages,
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: MgSizes.sm),
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(MgRadius.sm),
            dashPattern: const [6, 3],
            strokeWidth: 1.5,
            color: MgColorScheme.gray5,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, size: 32, color: MgColorScheme.gray5),
                Gaps.h4,
                Text('${_storeImages.length}/$_maxStoreImages')
                    .textColor(MgColorScheme.gray5)
                    .xs(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreImageItem(int index) {
    final image = _storeImages[index];
    final imageProvider = image.file != null
        ? DecorationImage(image: FileImage(image.file!), fit: BoxFit.cover)
        : image.uploadedUrl != null
            ? DecorationImage(image: NetworkImage(image.uploadedUrl!), fit: BoxFit.cover)
            : null;

    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: MgSizes.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MgRadius.sm),
            border: Border.all(color: MgColorScheme.gray7),
            image: imageProvider,
          ),
        ),
        Positioned(
          top: 4,
          right: 4 + MgSizes.sm,
          child: GestureDetector(
            onTap: () => setState(() => _storeImages.removeAt(index)),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickStoreImages() async {
    final remaining = _maxStoreImages - _storeImages.length;
    if (remaining <= 0) return;
    final files = await ImageRequester().pickMultipleFilesFromGallery(
      quality: 85,
      maxWidth: 1920,
      maxHeight: 1920,
    );
    if (files.isEmpty) return;
    setState(() {
      for (final file in files.take(remaining)) {
        _storeImages.add(LocalImage(
          id: _storeImages.length + 1,
          key: file.path.split('/').last,
          file: file,
        ));
      }
    });
  }

  // ─── 상품 정보 섹션 ────────────────────────────────────────────────────────

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
        _buildGoodsImageSection(),
      ],
    );
  }

  Widget _buildGoodsImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 새로 추가하는 상품 이미지
        ..._goodsDetails.asMap().entries.map((entry) {
          final index = entry.key;
          final detail = entry.value;
          return GoodsDetailInfoFormItem(
            key: ValueKey(index),
            index: index,
            onRemove: () => setState(() => _goodsDetails.removeAt(index)),
            onImageChanged: (file) {
              if (file != null) {
                setState(() {
                  _goodsDetails[index] = _goodsDetails[index].copyWith(
                    localImage: _goodsDetails[index].localImage.copyWith(file: file),
                  );
                });
              }
            },
            onNameChanged: (name) {
              _goodsDetails[index] = _goodsDetails[index].copyWith(name: name);
            },
            initialImage: detail.localImage.file,
            initialImageUrl: detail.localImage.uploadedUrl,
            initialName: detail.name,
          );
        }),
        GestureDetector(
          onTap: _addGoodsDetail,
          behavior: HitTestBehavior.opaque,
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(MgRadius.md),
              dashPattern: const [8, 4],
              color: MgColorScheme.gray5,
              strokeWidth: 1.5,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Center(
                child: BaseSvgIcon.plus().margin(vertical: MgSizes.sm),
              ),
            ),
          ).constrained(width: double.infinity, height: 48),
        ),
      ],
    );
  }

  Future<void> _addGoodsDetail() async {
    final file = await ImageRequester().pickFileFromGallery(
      quality: 85,
      maxWidth: 1920,
      maxHeight: 1920,
    );
    if (file != null) {
      setState(() {
        _goodsDetails.add(GoodsDetailItem(
          localImage: LocalImage(
            id: _goodsDetails.length + 1,
            key: file.path.split('/').last,
            file: file,
          ),
          name: '',
        ));
      });
    }
  }

  // ─── 주소 검색 ────────────────────────────────────────────────────────────

  Future<void> _findAddress() async {
    await Navigator.push<Kpostal>(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          callback: (Kpostal result) async {
            final latLng = await _geocodeWithKakao(result.address);
            if (latLng != null) {
              _latitude = latLng.$1;
              _longitude = latLng.$2;
            } else if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('위치 정보를 가져올 수 없습니다. 주소는 저장되었습니다.'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
            form.control('address').value = result.address;
          },
        ),
      ),
    );
  }

  Future<(double, double)?> _geocodeWithKakao(String query) async {
    final dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': 'KakaoAK ${Environment.kakaoRestApiKey}',
          'KA': 'sdk/1.0 flutter os/ios-17.0 lang/ko-KR',
        },
      ),
    );
    try {
      final res = await dio.get(
        'https://dapi.kakao.com/v2/local/search/address.json',
        queryParameters: {'query': query},
      );
      if (res.statusCode != 200 || res.data == null) return null;
      final docs = (res.data as Map<String, dynamic>)['documents'] as List<dynamic>;
      if (docs.isEmpty) return null;
      final first = docs.first as Map<String, dynamic>;
      final x = double.tryParse(first['x']?.toString() ?? '');
      final y = double.tryParse(first['y']?.toString() ?? '');
      if (x == null || y == null) return null;
      return (y, x); // y=lat, x=lng
    } catch (_) {
      return null;
    }
  }

  // ─── Form ─────────────────────────────────────────────────────────────────

  void _initializeForm() {
    final store = widget.store;
    form = FormGroup({
      'storeName': FormControl<String>(
        value: store.storeName,
        validators: [Validators.required],
      ),
      'description': FormControl<String>(value: store.description ?? ''),
      'address': FormControl<String>(
        value: store.address,
        validators: [Validators.required],
      ),
      'pickupTime': FormControl<String>(
        value: "${store.startTime.convertTime()} ~ ${store.endTime.convertTime()}",
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
      'parkingDescription': FormControl<String>(value: store.parkingDescription ?? ''),
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

  // ─── 수정 완료 ────────────────────────────────────────────────────────────

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

  Future<void> _manageStore(int storeId) async {
    // 대표 이미지: 기존 URL 이미지 + 새 로컬 이미지
    // 새 이미지 id는 기존 이미지 수 + 1부터 시작하여 충돌 방지
    final existingStoreCount = _storeImages.where((img) => img.uploadedUrl != null).length;
    int newStoreImageIndex = existingStoreCount + 1;  // 기존 1개면 새 이미지는 2부터
    final storeImageUploads = _storeImages.map((img) {
      if (img.uploadedUrl != null) {
        return {'id': 0, 'key': '', 'imageUrl': img.uploadedUrl!};
      } else {
        return {'id': newStoreImageIndex++, 'key': img.key, 'imageUrl': ''};
      }
    }).toList();

    // 상품 이미지: 기존 굿즈 + 새 굿즈
    // 새 이미지 id는 기존 이미지 수 + 1부터 시작하여 충돌 방지
    final existingGoodsCount = _goodsDetails.where((d) => d.localImage.file == null).length;
    int newGoodsIndex = existingGoodsCount + 1;
    final goodsImageUploads = _goodsDetails.map((detail) {
      if (detail.localImage.file != null) {
        return {'id': newGoodsIndex++, 'key': detail.localImage.key, 'imageUrl': '', 'goodsName': detail.name};
      } else {
        return {'id': 0, 'key': detail.localImage.key, 'imageUrl': detail.localImage.uploadedUrl ?? '', 'goodsName': detail.name};
      }
    }).toList();

    final goodsName = _goodsDetails.isNotEmpty
        ? (_goodsDetails.first.name.isNotEmpty ? _goodsDetails.first.name : 'goods')
        : (widget.store.goodsImageList.isNotEmpty
            ? (widget.store.goodsImageList.first.goodsName?.isNotEmpty == true
                ? widget.store.goodsImageList.first.goodsName!
                : 'goods')
            : (widget.store.goodsName?.isNotEmpty == true ? widget.store.goodsName! : 'goods'));

    final result = await ref.read(adminRepositoryProvider).manageStore(
      storeId,
      storeName: form.control('storeName').value as String,
      address: form.control('address').value as String,
      latitude: _latitude,
      longitude: _longitude,
      ownerName: form.control('representativeName').value as String,
      ownerPhone: form.control('representativePhone').value as String,
      businessNumber: form.control('businessNumber').value as String,
      bankName: form.control('bankName').value as String,
      bankAccount: form.control('accountNumber').value as String,
      description: form.control('description').value as String,
      parkingDescription: form.control('parkingDescription').value as String,
      storeImages: storeImageUploads,
      startTime: widget.store.startTime,
      endTime: widget.store.endTime,
      originalPrice: int.parse(form.control('originPrice').value as String),
      discount: int.parse(
        (form.control('discount').value as String).replaceAll('%', ''),
      ),
      salePrice: (int.parse(form.control('originPrice').value as String) *
              (1 - int.parse((form.control('discount').value as String).replaceAll('%', '')) / 100))
          .round(),
      quantity: int.parse(form.control('quantity').value as String),
      saleStatus: widget.store.saleStatus,
      goodsName: goodsName,
      goodsImages: goodsImageUploads,
    );

    if (result == null) {
      if (mounted) ToastPresentor.error(context, '수정이 완료되지 않았습니다');
      return;
    }

    // 새로 추가한 이미지만 S3 업로드 (순서 기반 매칭)
    final newStoreLocalImages = _storeImages.where((img) => img.file != null).toList();
    final storeUrlsToUpload = result.storeUrls.where((u) => u.url != null).toList();
    for (var i = 0; i < newStoreLocalImages.length && i < storeUrlsToUpload.length; i++) {
      await ref.read(presignedImageRepositoryProvider).uploadToS3WithPresignedUrl(
        presignedUrl: storeUrlsToUpload[i].url!,
        file: newStoreLocalImages[i].file!,
      );
    }

    final newGoodsLocalImages = _goodsDetails.where((d) => d.localImage.file != null).map((d) => d.localImage).toList();
    final goodsUrlsToUpload = result.goodsUrls.where((u) => u.url != null).toList();
    for (var i = 0; i < newGoodsLocalImages.length && i < goodsUrlsToUpload.length; i++) {
      await ref.read(presignedImageRepositoryProvider).uploadToS3WithPresignedUrl(
        presignedUrl: goodsUrlsToUpload[i].url!,
        file: newGoodsLocalImages[i].file!,
      );
    }

    if (mounted) {
      context.pop();
      ToastPresentor.success(context, '수정이 완료되었습니다');
      ref.invalidate(pendingStoreListProvider);
    }
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }
}
