import 'package:flutter/widgets.dart';
import 'package:magambell/src/constants/mg_sizes.dart';

class Gutter {
  Gutter._();

  static EdgeInsets w(double width) => EdgeInsets.symmetric(horizontal: width);
  static EdgeInsets h(double height) => EdgeInsets.symmetric(vertical: height);
  static EdgeInsets all(double size) => EdgeInsets.all(size);

  static const wxss = EdgeInsets.symmetric(horizontal: MgSizes.xss);
  static const wxs = EdgeInsets.symmetric(horizontal: MgSizes.xs);
  static const wsm = EdgeInsets.symmetric(horizontal: MgSizes.sm);
  static const wmd = EdgeInsets.symmetric(horizontal: MgSizes.md);
  static const wlg = EdgeInsets.symmetric(horizontal: MgSizes.lg);
  static const wxl = EdgeInsets.symmetric(horizontal: MgSizes.xl);
  static const wxxl = EdgeInsets.symmetric(horizontal: MgSizes.xxl);
  static const wxxxl = EdgeInsets.symmetric(horizontal: MgSizes.xxxl);

  static const hxss = EdgeInsets.symmetric(vertical: MgSizes.xss);
  static const hxs = EdgeInsets.symmetric(vertical: MgSizes.xs);
  static const hsm = EdgeInsets.symmetric(vertical: MgSizes.sm);
  static const hmd = EdgeInsets.symmetric(vertical: MgSizes.md);
  static const hlg = EdgeInsets.symmetric(vertical: MgSizes.lg);
  static const hxl = EdgeInsets.symmetric(vertical: MgSizes.xl);
  static const hxxl = EdgeInsets.symmetric(vertical: MgSizes.xxl);
  static const hxxxl = EdgeInsets.symmetric(vertical: MgSizes.xxxl);

  static const xxxs = EdgeInsets.all(MgSizes.xss);
  static const xxs = EdgeInsets.all(MgSizes.xs);
  static const xs = EdgeInsets.all(MgSizes.sm);
  static const sm = EdgeInsets.all(MgSizes.md);
  static const md = EdgeInsets.all(MgSizes.lg);
  static const lg = EdgeInsets.all(MgSizes.xl);
  static const xl = EdgeInsets.all(MgSizes.xxl);
  static const xxl = EdgeInsets.all(MgSizes.xxxl);
  static const xxxl = EdgeInsets.all(MgSizes.xxxxl);
}
