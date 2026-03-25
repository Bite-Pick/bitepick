import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/datetime_extension.dart';
import 'package:magambell/src/core/extensions/price_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';

import 'package:magambell/src/features/map/presentation/widget/store_location_info_view.dart';

import 'package:magambell/src/features/store/domain/entities/store_info_ui_data.dart';
import 'package:magambell/src/features/store/presentation/widget/store_favorite_icon.dart';
import 'package:magambell/src/features/store/presentation/widget/store_tags.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_network_image.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';

class StoreInfoView extends ConsumerWidget {
  const StoreInfoView(this.storeInfo, {super.key, this.hasFavorite = true});
  final StoreInfoUiData storeInfo;
  final bool hasFavorite;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThumbnailImageView(),
        _buildStoreDescriptionSection(context, ref),
        Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.md),
        _buildStoreLocationInfoSection(context),
        Divider(thickness: MgSizes.size6).margin(vertical: MgSizes.md),
      ],
    );
  }

  Widget _buildThumbnailImageView() {
    List<String> imageUrls = storeInfo.imageUrls;
    if (storeInfo.imageUrls.isEmpty) {
      return Container(
        height: 300,
        color: MgColorScheme.gray2,
        child: Center(child: Text('이미지 없음').textGray()),
      );
    }

    final isBeforeOpen = storeInfo.saleStatus == 'OFF';

    return Stack(
      children: [
        SizedBox(
          height: 240,
          child: Swiper(
            autoplay: true,
            autoplayDelay: 4000,
            loop: imageUrls.length > 1,
            itemCount: imageUrls.length,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: MgColorScheme.primary,
                color: MgColorScheme.gray4,
              ),
            ),
            itemBuilder: (context, index) {
              final imageUrl = imageUrls[index];
              if (imageUrl.isEmpty) {
                return Container(
                  color: MgColorScheme.gray2,
                  child: Center(child: Text('이미지 없음').textGray()),
                );
              }
              return BaseNetworkImage(imageUrl: imageUrl, borderRadius: 0);
            },
          ),
        ),
        if (isBeforeOpen)
          Positioned.fill(
            child: Container(
              color: MgColorScheme.gray0.withValues(alpha: 0.5),
              child: Center(
                child: Text(
                  '오픈 준비 중',
                  style: const TextStyle(
                    color: MgColorScheme.gray11,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStoreDescriptionSection(BuildContext context, WidgetRef ref) {
    final user = ref.read(userStateProvider).asData!.value;
    final isLogin = user != null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreTags(
              quantity: storeInfo.stockQuantity,
              saleStatus: storeInfo.saleStatus,
            ),

            Text(storeInfo.storeName).md().bold(),
            if (storeInfo.description.isNotEmpty)
              Text(storeInfo.description, softWrap: true).regular().textGray().margin(
                top: MgSizes.size4,
                bottom: MgSizes.size8,
              ), //description
            DefaultTextStyle(
              style: context.textTheme.titleLarge!,
              child: Row(
                children: [
                  Text('${storeInfo.discount}%').red(),
                  Text(
                    '${storeInfo.salePrice.toPrice()}원',
                  ).margin(left: MgSizes.size4, right: MgSizes.size8),
                  Text(
                    '${storeInfo.originPrice.toPrice()}원',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: MgColorScheme.gray6,
                      color: MgColorScheme.gray6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
        if (hasFavorite && isLogin) StoreFavoriteIcon(storeInfo.storeId),
      ],
    ).margin(all: MgSizes.md, bottom: 0);
  }

  Widget _buildStoreLocationInfoSection(BuildContext context) {
    return Column(
      spacing: MgSizes.size8,
      children: [
        _buildStoreInfoItem("남은재고", "${storeInfo.stockQuantity}개"),
        if (storeInfo.startTime.isNotEmpty && storeInfo.endTime.isNotEmpty)
          _buildStoreInfoItem(
            '픽업시간',
            "${storeInfo.startTime.convertTime()} ~ ${storeInfo.endTime.convertTime()}",
          ),
        if (storeInfo.parkingDescription != null)
          _buildStoreInfoItem(
            '주차안내',
            storeInfo.parkingDescription!,
          ), // TODO: 주차안내 field 추가 이후 테스트
        _buildStoreInfoItem(
          '가게 주소',
          storeInfo.address,
          suffix: GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: storeInfo.address));
              ToastPresentor.info(context, "복사완료!");
            },
            child: const Text("복사").textColor(Color(0xff0077FF)),
          ),
        ),
        if (storeInfo.latitude != null && storeInfo.longitude != null)
          StoreLocationInfoView(
            storeId: storeInfo.storeId,
            latitude: storeInfo.latitude!,
            longitude: storeInfo.longitude!,
            storeName: storeInfo.storeName,
            address: storeInfo.address,
          ).margin(vertical: MgSizes.md),
      ],
    ).margin(horizontal: MgSizes.md);
  }

  Widget _buildStoreInfoItem(String label, String value, {Widget? suffix}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).md().textGray().bold(),
        Gaps.w12,
        Expanded(child: Text(value).md().regular().max(2)),
        Gaps.w4,
        suffix ?? const SizedBox.shrink(),
      ],
    );
  }
}
