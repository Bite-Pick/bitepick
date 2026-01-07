part of 'mg_tooltip.dart';

/// 화살표 위치를 지정하는 클래스
/// top, bottom, left, right 중 원하는 값만 지정 가능
class ArrowPosition {
  const ArrowPosition({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
}

class _MgTooltipItem extends StatelessWidget {
  const _MgTooltipItem(
    this.content, {
    this.alignment,
    this.arrowAlignment,
    Color? backgroundColor,
    bool? showArrow,
  }) : _backgroundColor = backgroundColor,
       _hasArrow = showArrow ?? true;

  final Widget? content;
  final Alignment? alignment;
  final ArrowPosition? arrowAlignment;
  final Color? _backgroundColor;
  final bool _hasArrow;

  Color getBackgroundColor(BuildContext context) {
    return _backgroundColor ?? MgColorScheme.gray2;
  }

  /// alignment가 수직 방향인지 확인
  /// * (Alignment.topCenter, Alignment.bottomCenter)등
  bool get isVertical => alignment?.y != 0;

  /// alignment 값에 따라 화살표가 앞에 올지 결정
  bool get isLeadingArrow {
    return alignment == Alignment.topCenter ||
        alignment == Alignment.centerLeft;
  }

  @override
  Widget build(BuildContext context) {
    final arrow = _hasArrow
        ? CustomPaint(
            size: isVertical ? const Size(12, 8) : const Size(8, 12),
            painter: _ArrowPainter(
              color: getBackgroundColor(context),
              isVertical: isVertical,
              isLeadingArrow: isLeadingArrow,
            ),
          )
        : null;

    final body = content != null
        ? DefaultTextStyle(
            style: const TextStyle(color: Color(0xff000000), fontSize: 12),
            child: Container(
              padding: Gutter.xxs,
              decoration: BoxDecoration(
                color: getBackgroundColor(context),
                borderRadius: BorderRadius.circular(5),
              ),
              child: content,
            ),
          )
        : null;

    // arrowAlignment이 있으면 Stack + Positioned로 자유 배치
    if (arrowAlignment != null && body != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          body,
          if (arrow != null)
            Positioned(
              top: arrowAlignment!.top,
              bottom: arrowAlignment!.bottom,
              left: arrowAlignment!.left,
              right: arrowAlignment!.right,
              child: arrow,
            ),
        ],
      );
    }

    // 기존 방식: isVertical에 따라 Stack 또는 Row
    final children = <Widget>[];
    if (arrow != null) children.add(arrow);
    if (body != null) children.add(body);

    return isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: isLeadingArrow ? children : children.reversed.toList(),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: isLeadingArrow ? children : children.reversed.toList(),
          );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.color,
    required this.isVertical,
    required this.isLeadingArrow,
  });

  final Color color;
  final bool isVertical;
  final bool isLeadingArrow;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final length = isVertical ? size.height : size.width;
    final width = isVertical ? size.width : size.height;
    final mid = width / 2;

    final path = Path();

    if (isVertical) {
      if (isLeadingArrow) {
        // 위쪽 화살표 (▲)
        path
          ..moveTo(mid, 0)
          ..lineTo(0, length)
          ..lineTo(width, length);
      } else {
        // 아래쪽 화살표 (▼)
        path
          ..moveTo(0, 0)
          ..lineTo(width, 0)
          ..lineTo(mid, length);
      }
    } else {
      if (isLeadingArrow) {
        // 왼쪽 화살표 (◀)
        path
          ..moveTo(0, mid)
          ..lineTo(length, 0)
          ..lineTo(length, width);
      } else {
        // 오른쪽 화살표 (▶)
        path
          ..moveTo(0, 0)
          ..lineTo(length, mid)
          ..lineTo(0, width);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) =>
      color != oldDelegate.color ||
      isVertical != oldDelegate.isVertical ||
      isLeadingArrow != oldDelegate.isLeadingArrow;
}
