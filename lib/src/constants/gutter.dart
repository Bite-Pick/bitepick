import 'package:flutter/widgets.dart';
import 'package:magambell/src/constants/mg_sizes.dart';

class Gutter {
  Gutter._();

  static EdgeInsets w(double width) => EdgeInsets.symmetric(horizontal: width);
  static EdgeInsets h(double height) => EdgeInsets.symmetric(vertical: height);
  static EdgeInsets all(double size) => EdgeInsets.all(size);

  static const wXss = EdgeInsets.symmetric(horizontal: MgSpacing.xss);
  static const wXs = EdgeInsets.symmetric(horizontal: MgSpacing.xs);
  static const wSm = EdgeInsets.symmetric(horizontal: MgSpacing.sm);
  static const wMd = EdgeInsets.symmetric(horizontal: MgSpacing.md);
  static const wLg = EdgeInsets.symmetric(horizontal: MgSpacing.lg);
  static const wXl = EdgeInsets.symmetric(horizontal: MgSpacing.xl);
  static const wXxl = EdgeInsets.symmetric(horizontal: MgSpacing.xxl);
  static const wXxxl = EdgeInsets.symmetric(horizontal: MgSpacing.xxxl);

  static const hXss = EdgeInsets.symmetric(vertical: MgSpacing.xss);
  static const hXs = EdgeInsets.symmetric(vertical: MgSpacing.xs);
  static const hSm = EdgeInsets.symmetric(vertical: MgSpacing.sm);
  static const hMd = EdgeInsets.symmetric(vertical: MgSpacing.md);
  static const hLg = EdgeInsets.symmetric(vertical: MgSpacing.lg);
  static const hXl = EdgeInsets.symmetric(vertical: MgSpacing.xl);
  static const hXxl = EdgeInsets.symmetric(vertical: MgSpacing.xxl);
  static const hXxxl = EdgeInsets.symmetric(vertical: MgSpacing.xxxl);
}
