import 'package:flutter/widgets.dart';

extension KnStyledWidget<T extends Widget> on T {
  Widget padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  Widget margin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  Widget decorated({
    Key? key,
    Color? color,
    BoxBorder? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    BoxShape? shape,
  }) {
    final BoxDecoration decoration = BoxDecoration(
      color: color,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      shape: shape ?? BoxShape.rectangle,
    );
    return DecoratedBox(key: key, child: this, decoration: decoration);
  }

  Widget constrained({
    Key? key,
    double? width,
    double? height,
    double minWidth = 0.0,
    double maxWidth = double.infinity,
    double minHeight = 0.0,
    double maxHeight = double.infinity,
  }) {
    BoxConstraints constraints = BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
    constraints = (width != null || height != null)
        ? constraints.tighten(width: width, height: height)
        : constraints;
    return ConstrainedBox(key: key, child: this, constraints: constraints);
  }

  Widget colored(Color color) => ColoredBox(color: color, child: this);
  
  Widget clipRRect({
    Key? key,
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) => ClipRRect(
    key: key,
    child: this,
    clipper: clipper,
    clipBehavior: clipBehavior,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? all ?? 0.0),
      topRight: Radius.circular(topRight ?? all ?? 0.0),
      bottomLeft: Radius.circular(bottomLeft ?? all ?? 0.0),
      bottomRight: Radius.circular(bottomRight ?? all ?? 0.0),
    ),
  );
}
