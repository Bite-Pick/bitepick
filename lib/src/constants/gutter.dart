import 'package:flutter/widgets.dart';
import 'package:magambell/src/constants/mg_sizes.dart';

class Gutter {
  Gutter._();

  static EdgeInsets w(double width) => EdgeInsets.symmetric(horizontal: width);
  static EdgeInsets h(double height) => EdgeInsets.symmetric(vertical: height);
  static EdgeInsets all(double size) => EdgeInsets.all(size);

  static const wxss = EdgeInsets.symmetric(horizontal: MgSpacing.xss);
  static const wxs = EdgeInsets.symmetric(horizontal: MgSpacing.xs);
  static const wsm = EdgeInsets.symmetric(horizontal: MgSpacing.sm);
  static const wmd = EdgeInsets.symmetric(horizontal: MgSpacing.md);
  static const wlg = EdgeInsets.symmetric(horizontal: MgSpacing.lg);
  static const wxl = EdgeInsets.symmetric(horizontal: MgSpacing.xl);
  static const wxxl = EdgeInsets.symmetric(horizontal: MgSpacing.xxl);
  static const wxxxl = EdgeInsets.symmetric(horizontal: MgSpacing.xxxl);

  static const hxss = EdgeInsets.symmetric(vertical: MgSpacing.xss);
  static const hxs = EdgeInsets.symmetric(vertical: MgSpacing.xs);
  static const hsm = EdgeInsets.symmetric(vertical: MgSpacing.sm);
  static const hmd = EdgeInsets.symmetric(vertical: MgSpacing.md);
  static const hlg = EdgeInsets.symmetric(vertical: MgSpacing.lg);
  static const hxl = EdgeInsets.symmetric(vertical: MgSpacing.xl);
  static const hxxl = EdgeInsets.symmetric(vertical: MgSpacing.xxl);
  static const hxxxl = EdgeInsets.symmetric(vertical: MgSpacing.xxxl);

  static const xxxs = EdgeInsets.all(MgSpacing.xss);
  static const xxs = EdgeInsets.all(MgSpacing.xs);
  static const xs = EdgeInsets.all(MgSpacing.sm);
  static const sm = EdgeInsets.all(MgSpacing.md);
  static const md = EdgeInsets.all(MgSpacing.lg);
  static const lg = EdgeInsets.all(MgSpacing.xl);
  static const xl = EdgeInsets.all(MgSpacing.xxl);
  static const xxl = EdgeInsets.all(MgSpacing.xxxl);
  static const xxxl = EdgeInsets.all(MgSpacing.xxxxl);
}
