import 'package:flutter/material.dart';

typedef MgBottomSetState = void Function(void Function());

typedef MgBottomSheetBuilder =
    Widget Function(BuildContext context, MgBottomSetState bottomState);

class MgBottomsheet extends StatelessWidget {
  const MgBottomsheet(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [SizedBox(width: double.infinity, child: child)],
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context,
    MgBottomSheetBuilder builder, {
    bool dimmed = true,
    VoidCallback? onClose,
    bool closable = true,
    bool isScrollControlled = true,
    double height = 500,
    Color? backgroundColor,
  }) async {
    final deviceHeight = MediaQuery.sizeOf(context).height;

    final viewPadding =
        MediaQuery.viewPaddingOf(context).top +
        MediaQuery.viewPaddingOf(context).bottom;

    onClose?.call();

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: closable,
      isScrollControlled: isScrollControlled,
      scrollControlDisabledMaxHeightRatio:
          height / (deviceHeight - viewPadding),
      backgroundColor: backgroundColor,
      builder: (context) {
        return StatefulBuilder(builder: builder);
      },
    );
  }
}
