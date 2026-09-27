import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';

import 'package:magambell/src/features/map/presentation/widget/store_location_info_view.dart';
import 'package:magambell/src/features/store/data/repositories/store_repository.dart';

import 'package:magambell/src/features/store/domain/entities/store_info_ui_data.dart';
import 'package:magambell/src/features/store/presentation/widget/store_favorite_icon.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

const _menuItemNameStyle = TextStyle(
  fontFamily: MgFontFamily.regular,
  fontWeight: FontWeight.w400,
  fontSize: 15,
  height: 1.5,
  letterSpacing: -0.375,
);

class StoreInfoView extends ConsumerWidget {
  const StoreInfoView(
    this.storeInfo, {
      super.key, 
      this.hasFavorite = true, 
      this.onPhotoChangeTap, 
      this.onMenuEditTap,
      this.reviewCount = 0,
  });
  final StoreInfoUiData storeInfo;
  final bool hasFavorite;
  final VoidCallback? onPhotoChangeTap;
  final VoidCallback? onMenuEditTap;
  final int reviewCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThumbnailImageView(),
        _buildStoreInfoSection(context, ref),
        _buildThinDivider(),
        _buildStoreDetailSection(context),
        Divider(height: MgSizes.size8, thickness: MgSizes.size8).margin(top: MgSizes.md),
        _buildMenuSection(context),
        _buildThinDivider(),
        _buildStoreLocationInfoSection(context, ref),
        _buildThinDivider(),
        _buildReviewSection(context),
      ],
    );
  }

  Widget _buildThumbnailImageView() {
    const imageWidth = 156.0;
    const imageHeight = 196.0;
    List<String> imageUrls = storeInfo.imageUrls;

    if (storeInfo.imageUrls.isEmpty) {
      return Container(
        height: imageHeight,
        color: MgColorScheme.gray2,
        child: Center(child: Text('이미지 없음').textGray()),
      );
    }

    return SizedBox(
      height: imageHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: MgSizes.md),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index];
          final isLast = index == imageUrls.length - 1;
          if (imageUrl.isEmpty) {
            return Container(
              width: imageWidth,
              height: imageHeight,
              margin: EdgeInsets.only(right: isLast ? 0 : MgSizes.xss),
              color: MgColorScheme.gray2,
            );
          }
          return BaseNetworkImage(
            imageUrl: imageUrl, 
            width: imageWidth,
            height: imageHeight,
            borderRadius: MgRadius.md,
            backgroundColor: NewColorScheme.gray12,
          ).margin(right: isLast ? 0 : MgSizes.xss);
        },
      ).margin(top: MgSizes.xl),
    );
  }

  Widget _buildStoreInfoSection(BuildContext context, WidgetRef ref) {
    final user = ref.read(userStateProvider).asData!.value;
    final isLogin = user != null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: MgSizes.xss,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      storeInfo.storeName,
                      style: context.textTheme.headlineMedium?.copyWith(color: NewColorScheme.gray1),
                    ),
                  ),
                  StoreTags(
                    quantity: storeInfo.stockQuantity,
                    saleStatus: storeInfo.saleStatus,
                    showSaleStatus: false,
                    compact: true,
                  ),
                ],
              ),
              Row(
                spacing: MgSizes.xss,
                children: [
                  Text(
                    '${storeInfo.discount}%',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: NewColorScheme.systemAlert,
                    ),
                  ),
                  Text(
                    '${storeInfo.salePrice.toPrice()}원',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: NewColorScheme.gray1,
                    ),
                  ),
                  Text(
                   '${storeInfo.originPrice.toPrice()}원',
                    style: context.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: NewColorScheme.gray7,
                      color: NewColorScheme.gray7,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (hasFavorite && isLogin) StoreFavoriteIcon(storeInfo.storeId),
      ],
    ).padding(horizontal: MgSizes.md, vertical: MgSizes.sm);
  }

  Widget _buildStoreDetailSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: MgSizes.xss,
      children: [
        Row(
          children: [
            BaseSvgIcon.timeNew(size: MgSizes.size16),
            Gaps.w8,
            Expanded(
              child: Text(
                "${storeInfo.startTime.convertTime()} ~ ${storeInfo.endTime.convertTime()}에 픽업",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: NewColorScheme.gray3,
                ),
              ),
            ),
          ],
        ),
        _ExpandableDescriptionRow(description: storeInfo.description),
      ],
    ).padding(top: MgSizes.sm, horizontal: MgSizes.md);
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = (storeInfo.goodsImageList ?? [])
        .where((g) => g.goodsName != null && g.goodsName!.isNotEmpty)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MgSizes.size48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: MgSizes.md),
                child: Row(
                  children: [
                    Text(
                      '메뉴',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: NewColorScheme.gray1,
                      ),
                    ),
                    Gaps.w4,
                    Text(
                      '${storeInfo.menuCount}',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: NewColorScheme.gray7,
                      ),
                    ),
                  ],
                ),
              ),
              if (onMenuEditTap != null)
                Padding(
                  padding: const EdgeInsets.only(right: MgSizes.md),
                  child: GestureDetector(
                    onTap: onMenuEditTap,
                    child: Row(
                      children: [
                        BaseSvgIcon.edit(size: MgSizes.size20),
                        Gaps.w2,
                        Text(
                          '수정',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: NewColorScheme.gray5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        Gaps.h4, 
        Container(
          height: 44,
          margin: const EdgeInsets.symmetric(horizontal: MgSizes.md),
          padding: const EdgeInsets.only(left: MgSizes.sm),
          decoration: BoxDecoration(
            border: Border.all(color: NewColorScheme.gray11, width: 1),
            borderRadius: BorderRadius.circular(MgRadius.md),
          ),
          child: Row(
            children: [
              Image.asset('assets/images/menu.png', width: 18, height: 18),
              Gaps.w8,
              Text(
                '아래의 메뉴 중 랜덤으로 구성돼요!',
                style: const TextStyle(
                  fontFamily: MgFontFamily.medium,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  height: 1.5,
                  letterSpacing: -0.325,
                  color: NewColorScheme.gray4,
                ),
              ),
            ],
          ),
        ),
        Gaps.h12,
        if (menuItems.isEmpty)
          Center(
            child: Column(
              children: [
                Gaps.h24,
                Image.asset(R.ASSETS_IMAGES_CHARACTER_EMPTY_PNG, width: 132),
                Gaps.h12,
                Text('앗! 아직 등록된 메뉴 소개가 없어요.').bold(),
              ],
            ),
          )
        else
          SizedBox(
            height: 132,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: MgSizes.md),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isLast = index == menuItems.length - 1;
                return Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : MgSizes.xss),
                  child: SizedBox(
                    width: 104,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseNetworkImage(
                          imageUrl: item.imageUrl ?? '',
                          width: 104,
                          height: 103,
                          borderRadius: MgRadius.sm,
                          backgroundColor: NewColorScheme.gray12,
                        ),
                        Gaps.h(MgSizes.size6),
                        Text(
                          item.goodsName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _menuItemNameStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    ).padding(top: MgSizes.xss, bottom: MgSizes.xl);
  }

  Widget _buildStoreLocationInfoSection(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(storeGoodsDetailProvider(storeInfo.storeId));
    final latitude = storeInfo.latitude ?? detailAsync.value?.latitude;
    final longitude = storeInfo.longitude ?? detailAsync.value?.longitude;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MgSizes.size48,
          child: Padding(
            padding: const EdgeInsets.only(left: MgSizes.md),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '가게',
                style: context.textTheme.titleLarge?.copyWith(
                  color: NewColorScheme.gray1,
                ),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: MgSizes.xss,
          children: [
            Row(
              children: [
                BaseSvgIcon.maps(size: MgSizes.size16),
                Gaps.w8,
                Expanded(
                  child: Text(
                    storeInfo.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: NewColorScheme.gray3,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                BaseSvgIcon.parking(size: MgSizes.size16),
                Gaps.w8,
                Expanded(
                  child: Text(
                    storeInfo.parkingDescription ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: NewColorScheme.gray3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).padding(horizontal: MgSizes.md),
        if (latitude != null && longitude != null)
          StoreLocationInfoView(
            storeId: storeInfo.storeId,
            latitude: latitude,
            longitude: longitude,
            storeName: storeInfo.storeName,
            address: storeInfo.address,
            mapHeight: 120,
          ).margin(top: MgSizes.md),
      ],
    ).padding(top: MgSizes.size6, bottom: MgSizes.xl);
  }

  Widget _buildReviewSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MgSizes.size48,
          child: Padding(
            padding: const EdgeInsets.only(left: MgSizes.md),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    '리뷰',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: NewColorScheme.gray1,
                    ),
                  ),
                  Gaps.w4,
                  Text(
                    '$reviewCount',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: NewColorScheme.gray7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (reviewCount == 0) 
          Center(
            child: Column(
              children: [
                Gaps.h24,
                Image.asset(R.ASSETS_IMAGES_CHARACTER_EMPTY_PNG, width: 160),
                Gaps.h12,
                Text('아직 등록된 리뷰가 없어요').bold(),
              ],
            ),
          ),
      ],
    ).padding(top: MgSizes.size6);
  }

  Widget _buildThinDivider() {
    return Container(
      height: MgSizes.size1,
      color: NewColorScheme.gray12,
      margin: const EdgeInsets.symmetric(horizontal: MgSizes.md),
    );
  }
}

class _ExpandableDescriptionRow extends StatefulWidget {
  const _ExpandableDescriptionRow({required this.description});
  final String description;

  @override
  State<_ExpandableDescriptionRow> createState() =>
      _ExpandableDescriptionRowState();
}

class _ExpandableDescriptionRowState
    extends State<_ExpandableDescriptionRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _expanded = !_expanded),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseSvgIcon.storeDescription(size: MgSizes.size16),
          Gaps.w8,
          Expanded(
            child: Text(
              widget.description,
              maxLines: _expanded ? null : 1,
              overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
              ),
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: NewColorScheme.gray3,
              ),
            ),
          ),
          Gaps.w8,
          _expanded
              ? BaseSvgIcon.caretUpMd(size: MgSizes.size20)
              : BaseSvgIcon.caretDownMd(size: MgSizes.size20),
        ],
      ),
    );
  }
}
