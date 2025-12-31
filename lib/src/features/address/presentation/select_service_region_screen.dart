import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/address/data/repositories/region_repository.dart';
import 'package:magambell/src/features/address/domain/entities/region.dart';
import 'package:magambell/src/features/address/presentation/select_service_region_screen.controller.dart';
import 'package:magambell/src/features/address/providers/region.provider.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_unsupported_area_view.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';

final _cellHeight = 42.h;

enum RegionSelectionLevel { city, district, town }

class SelectServiceRegionRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SelectServiceRegionScreen();
  }
}

class SelectServiceRegionScreen extends ConsumerStatefulWidget {
  const SelectServiceRegionScreen({super.key});

  @override
  ConsumerState<SelectServiceRegionScreen> createState() =>
      _SelectServiceRegionScreenState();
}

class _SelectServiceRegionScreenState
    extends ConsumerState<SelectServiceRegionScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: Text("서비스 지역 요청")),
      body: Column(
        children: [
          _buildTopInfoSection(),
          Divider(thickness: 1, color: MgColorScheme.gray8),
          Expanded(child: _buildRegionTableSection()),
        ],
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final controllerState = ref.watch(
            selectServiceRegionScreenControllerProvider,
          );
          final isComplete =
              controllerState.selectedCity != null &&
              controllerState.selectedDistrict != null &&
              controllerState.selectedTown != null;

          return MgButton(
            disabled: !isComplete,
            onPressed: () => requestOpenRegion(controllerState),
            content: Text("서비스 지역 요청하기"),
          ).primary().margin(vertical: MgSizes.lg, horizontal: MgSizes.md);
        },
      ),
    );
  }

  Future<void> requestOpenRegion(
    SelectServiceRegionState controllerState,
  ) async {
    final regionId =
        controllerState.selectedTown?.id ??
        controllerState.selectedDistrict?.id;
    final res = await ref
        .read(regionRepositoryProvider)
        .requestOpenRegion(regionId: regionId!);
    if (res) {
      // context.pop();
      await showDialog(
        context: context,
        builder: (context) => HomeUnsupportedAreaView.share(
          onPressed: () {
            Future<void> shareKakao() async {
              final bool isKakaoTalkSharingAvailable = await ShareClient
                  .instance
                  .isKakaoTalkSharingAvailable();

              if (isKakaoTalkSharingAvailable) {
                try {
                  Uri uri = await ShareClient.instance.shareCustom(
                    templateId: Environment.kakaoShareTemplateId,
                  );
                  await ShareClient.instance.launchKakaoTalk(uri);
                  talker.info('카카오톡 공유 완료');
                } catch (error) {
                  talker.error('카카오톡 공유 실패 $error');
                }
              } else {
                try {
                  Uri shareUrl = await WebSharerClient.instance.makeCustomUrl(
                    templateId: Environment.kakaoShareTemplateId,
                  );
                  await launchBrowserTab(shareUrl, popupOpen: true);
                } catch (error) {
                  talker.error('카카오톡 공유 실패 $error');
                }
              }
            }
          },
        ),
      );
    }
  }

  Widget _buildTopInfoSection() {
    return Row(
          children: [
            Image.asset(R.ASSETS_IMAGES_CHARACTER_STANDING_PNG, width: 46),
            Gaps.w24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("우리 동네도 서비스해주세요").md().bold(),
                Gaps.h4,
                Text("지역을 선택하고 오픈을 요청해보세요 🍞").textColor(MgColorScheme.gray4),
              ],
            ),
          ],
        )
        .margin(horizontal: MgSizes.xxl + 2, vertical: MgSizes.lg)
        .colored(MgColorScheme.primaryLightest);
  }

  Widget _buildRegionTableSection() {
    final citiesAsync = ref.watch(regionCitiesProvider);
    final controllerState = ref.watch(
      selectServiceRegionScreenControllerProvider,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: MgAsyncAnimatedSwitcher(
              asyncValue: citiesAsync,
              builder: (cities) {
                return _buildTableColumn(
                  '시 ∙ 도',
                  cities,
                  onTap: (city) {
                    ref
                        .read(
                          selectServiceRegionScreenControllerProvider.notifier,
                        )
                        .selectCity(city);
                  },
                  selectedId: controllerState.selectedCity?.id,
                  level: RegionSelectionLevel.city,
                );
              },
            ),
          ),
          VerticalDivider(width: 1, thickness: 1, color: MgColorScheme.gray8),

          Expanded(
            flex: 2,
            child: _buildTableColumn(
              '시 ∙ 군 ∙ 구',
              controllerState.districts,
              onTap: (district) {
                ref
                    .read(selectServiceRegionScreenControllerProvider.notifier)
                    .selectDistrict(district);
              },
              selectedId: controllerState.selectedDistrict?.id,
              level: RegionSelectionLevel.district,
              allRegion: controllerState.selectedCity,
            ),
          ),
          VerticalDivider(width: 1, thickness: 1, color: MgColorScheme.gray8),

          Expanded(
            flex: 2,
            child: _buildTableColumn(
              '동 ∙ 읍 ∙ 면',
              controllerState.towns,
              onTap: (town) {
                ref
                    .read(selectServiceRegionScreenControllerProvider.notifier)
                    .selectTown(town);
              },
              selectedId: controllerState.selectedTown?.id,
              level: RegionSelectionLevel.town,
              allRegion: controllerState.selectedDistrict,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableColumn(
    String title,
    List<Region> contents, {
    required Function(Region) onTap,
    required RegionSelectionLevel level,
    int? selectedId,
    Region? allRegion,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTableTitle(title),
        Expanded(
          child: ListView(
            children: [
              if (contents.isNotEmpty && allRegion != null)
                GestureDetector(
                  onTap: () => onTap(allRegion),
                  child: _RegionTableCell(
                    '${allRegion.displayName} 전체',
                    isSelected: allRegion.id == selectedId,
                    level: RegionSelectionLevel
                        .town, // NOTE: 마지막 선택지는 check 표시로 선택
                  ),
                ),
              ...contents.map(
                (region) => GestureDetector(
                  onTap: () => onTap(region),
                  child: switch (level) {
                    RegionSelectionLevel.city => _RegionTableCell.city(
                      region.name,
                      isSelected: selectedId == region.id,
                    ),
                    RegionSelectionLevel.district => _RegionTableCell.district(
                      region.displayName, // 00시 00구 띄어쓰기 정규표현식 적용
                      isSelected: selectedId == region.id,
                    ),
                    RegionSelectionLevel.town => _RegionTableCell.town(
                      region.name,
                      isSelected: selectedId == region.id,
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableTitle(String text) {
    return Text(text)
        .sm()
        .center()
        .bold()
        .margin(vertical: MgSizes.sm)
        .decorated(
          color: MgColorScheme.gray10,
          border: Border(
            bottom: BorderSide(color: MgColorScheme.gray8, width: 1),
          ),
        )
        .constrained(height: _cellHeight, width: double.infinity);
  }
}

class _RegionTableCell extends StatelessWidget {
  const _RegionTableCell(
    this.text, {
    super.key,
    required this.isSelected,
    required this.level,
  });

  final String text;
  final bool isSelected;
  final RegionSelectionLevel level;

  factory _RegionTableCell.city(String text, {required bool isSelected}) {
    return _RegionTableCell(
      text,
      isSelected: isSelected,
      level: RegionSelectionLevel.city,
    );
  }

  factory _RegionTableCell.district(String text, {required bool isSelected}) {
    return _RegionTableCell(
      text,
      isSelected: isSelected,
      level: RegionSelectionLevel.district,
    );
  }

  factory _RegionTableCell.town(String text, {required bool isSelected}) {
    return _RegionTableCell(
      text,
      isSelected: isSelected,
      level: RegionSelectionLevel.town,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isSelected) {
      return Text(text)
          .textColor(MgColorScheme.gray4)
          .fontWeight(FontWeight.w400)
          .margin(left: MgSizes.md, vertical: MgSizes.sm)
          .colored(MgColorScheme.gray11)
          .constrained(height: _cellHeight, width: double.infinity);
    }

    return switch (level) {
      RegionSelectionLevel.city => _buildCityStyle(),
      RegionSelectionLevel.district => _buildDistrictStyle(),
      RegionSelectionLevel.town => _buildTownStyle(),
    };
  }

  Widget _buildCellText() => Text(text).textColor(MgColorScheme.gray1).bold();

  Widget _buildCityStyle() {
    // 1단계: 노란색 배경 (이미지의 1번)
    return _buildCellText()
        .margin(left: MgSizes.md, vertical: MgSizes.sm)
        .colored(MgColorScheme.primary) // 노란색 배경
        .constrained(height: _cellHeight, width: double.infinity);
  }

  Widget _buildDistrictStyle() {
    // 2단계: 테두리만 (이미지의 2번)
    return _buildCellText()
        .margin(left: MgSizes.md, vertical: MgSizes.sm)
        .colored(MgColorScheme.primaryLightest)
        .constrained(height: _cellHeight, width: double.infinity);
  }

  Widget _buildTownStyle() {
    // 3단계: 텍스트 색상만 (이미지의 3번)
    return Row(
          children: [
            Expanded(child: _buildCellText()),
            BaseSvgIcon.check(color: MgColorScheme.primary),
          ],
        )
        .margin(horizontal: MgSizes.md, vertical: MgSizes.sm)
        .constrained(height: _cellHeight, width: double.infinity);
  }
}
