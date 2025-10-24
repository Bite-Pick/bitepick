import 'package:flutter/material.dart';

extension ListWidgetExtension on Iterable<Widget> {
  List<Widget> joinWithWidget(Widget separator) {
    final Iterator<Widget> iterator = this.iterator;
    if (!iterator.moveNext()) return [];
    final widgets = <Widget>[];

    widgets.add(iterator.current);
    while (iterator.moveNext()) {
      widgets.add(separator);
      widgets.add(iterator.current);
    }

    return widgets;
  }
}
