import 'package:flutter/material.dart';
import 'package:magambell/src/core/config/environment.dart';

/// Development flavor에서만 표시되는 디버그 텍스트 위젯
///
/// Usage:
/// ```dart
/// DebugText('디버그 메시지')
/// DebugText('커스텀 스타일', style: TextStyle(color: Colors.red))
/// ```
class DebugText extends StatelessWidget {
  const DebugText(this.text, {this.style, super.key});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    // development flavor가 아니면 빈 위젯 반환
    if (!Environment.instance.isDev) {
      return const SizedBox.shrink();
    }

    return Text(
      text,
      style:
          style ??
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
    );
  }
}
