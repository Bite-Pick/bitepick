import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

enum OrderOwnerStatus { paid, accepted, completed }

extension OrderOwnerStatusExt on OrderOwnerStatus {
  String get tabName {
    switch (this) {
      case OrderOwnerStatus.paid:
        return '대기';
      case OrderOwnerStatus.accepted:
        return '진행';
      case OrderOwnerStatus.completed:
        return '완료';
    }
  }

  String get label {
    switch (this) {
      case OrderOwnerStatus.paid:
        return '대기';
      case OrderOwnerStatus.accepted:
        return '진행';
      case OrderOwnerStatus.completed:
        return '완료';
    }
  }

  Color get color {
    switch (this) {
      case OrderOwnerStatus.paid:
        return MgColorScheme.primary;
      case OrderOwnerStatus.accepted:
        return MgColorScheme.secondary;
      case OrderOwnerStatus.completed:
        return MgColorScheme.gray5;
    }
  }
}
