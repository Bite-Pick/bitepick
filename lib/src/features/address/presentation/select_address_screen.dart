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
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:magambell/src/features/address/presentation/search_address_screen.controller.dart';
import 'package:magambell/src/widgets/base_appbar.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
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
    return BaseScaffold(
      appBar: BaseAppBar(leading: SizedBox.shrink()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("바이트픽\n어느지역에서 만나볼까요?").bold().xl(),
          Gaps.h12,
          Text("서비스중인 지역을 먼저보여드릴게요!\n조금씩 매장이 늘어날 예정이니까 조금만 기다려주세요").textGray(),
          Gaps.h40,

          ..._buildServiceAreas(),
          Spacer(),
          MgButton(
            onPressed: () {
              DefaultRoute().go(context);
            },
            content: Text("확인"),
          ).primary(),
        ],
      ).margin(horizontal: MgSizes.md),
    );
  }

  List<Widget> _buildServiceAreas() {
    return serviceAreas
        .mapIndexed((index, address) {
          final isSelect = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              ref
                  .read(searchAddressScreenControllerProvider.notifier)
                  .selectFromSaved(address);
            },
            child:
                Row(
                      children: [
                        BaseSvgIcon.mapPin(size: 20),
                        Text(
                          address.label,
                        ).md().margin(left: MgSizes.sm, right: MgSizes.xs),
                        if (isSelect) ...[
                          const Spacer(),
                          BaseSvgIcon.check(size: 20),
                        ],
                      ],
                    )
                    .margin(all: MgSizes.md)
                    .decorated(
                      border: Border.all(
                        color: isSelect
                            ? MgColorScheme.gray4
                            : MgColorScheme.gray7,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      color: isSelect ? MgColorScheme.gray10 : null,
                    ),
          );
        })
        .joinWithWidget(Gaps.h12);
  }
}
