import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/address/data/repositories/region_repository.dart';
import 'package:magambell/src/features/home/presentation/home_screen.controller.dart';
import 'package:magambell/src/features/user/providers/user.provider.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/mg_async_animated_switcher.dart';
import 'package:magambell/src/widgets/mg_button.dart';

class SelectAddressRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SelectAddressScreen();
  }
}

class SelectAddressScreen extends ConsumerStatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  ConsumerState<SelectAddressScreen> createState() =>
      _SelectAddressScreenState();
}

class _SelectAddressScreenState extends ConsumerState<SelectAddressScreen> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final serviceAddressesAsync = ref.watch(serviceAddressesProvider);
    return BaseScaffold(
      appBar: BaseAppBar(leading: SizedBox.shrink()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("바이트픽\n어느지역에서 만나볼까요?").bold().xl(),
          Gaps.h12,
          Text(
            "서비스중인 지역을 먼저보여드릴게요\n더 많은 지역에서 곧 만나볼 수 있으니, 조금만 기다려주세요",
          ).textGray(),
          Gaps.h40,
          MgAsyncAnimatedSwitcher(
            asyncValue: serviceAddressesAsync,
            builder: (serviceAddresses) {
              return Column(
                children: serviceAddresses
                    .mapIndexed((index, address) {
                      final isSelect = _selectedIndex == index;

                      return GestureDetector(
                        onTap: () async {
                          setState(() => _selectedIndex = index);
                          await ref
                              .read(homeScreenControllerProvider.notifier)
                              .saveToStorage(address);
                        },
                        child: _buildServiceAddressItem(
                          address.label,
                          isSelect,
                        ),
                      );
                    })
                    .joinWithWidget(Gaps.h12),
              );
            },
          ),
          const Spacer(),
          MgButton(
            // 주소를 선택해야만 확인 버튼 활성화
            onPressed: _selectedIndex != null
                ? () {
                    ref.invalidate(userStateProvider);
                    DefaultRoute().go(context);
                  }
                : null,
            content: const Text("확인"),
          ).primary(),
        ],
      ).margin(horizontal: MgSizes.md),
    );
  }

  Widget _buildServiceAddressItem(String label, bool isSelect) {
    return Row(
          children: [
            BaseSvgIcon.mapPin(size: 20),
            Text(label).md().margin(left: MgSizes.sm, right: MgSizes.xs),
            if (isSelect) ...[const Spacer(), BaseSvgIcon.check(size: 20)],
          ],
        )
        .margin(all: MgSizes.md)
        .decorated(
          border: Border.all(
            color: isSelect ? MgColorScheme.gray4 : MgColorScheme.gray7,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelect ? MgColorScheme.gray10 : null,
        );
  }
}
