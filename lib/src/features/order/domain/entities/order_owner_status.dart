import 'package:flutter/material.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

enum OrderOwnerStatus { PAID, ACCEPTED, COMPLETED, CANCELED }

// TODO: CANCELED 상태 표시되는지 확인
extension OrderOwnerStatusExt on OrderOwnerStatus {
  String get tabName {
    switch (this) {
      case OrderOwnerStatus.PAID:
        return '대기';
      case OrderOwnerStatus.ACCEPTED:
        return '진행';
      case OrderOwnerStatus.COMPLETED:
        return '완료';
      case OrderOwnerStatus.CANCELED:
        return '완료';
    }
  }

  String get label {
    switch (this) {
      case OrderOwnerStatus.PAID:
        return '접수 대기';
      case OrderOwnerStatus.ACCEPTED:
        return '진행중';
      case OrderOwnerStatus.COMPLETED:
        return '완료';
      case OrderOwnerStatus.CANCELED:
        return '취소';
    }
  }

  Color get color {
    switch (this) {
      case OrderOwnerStatus.PAID:
        return MgColorScheme.systemWarning;
      case OrderOwnerStatus.ACCEPTED:
        return Color(0xff4887D9);
      case OrderOwnerStatus.COMPLETED:
        return Color(0xff4CAF50);
      case OrderOwnerStatus.CANCELED:
        return MgColorScheme.systemError;
    }
  }
}
