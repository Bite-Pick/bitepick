import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

enum OrderGuestStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('PAID')
  paid,
  @JsonValue('ACCEPTED')
  accepted,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELED')
  canceled,
  @JsonValue('FAILED')
  failed,
}

extension OrderStatusExt on OrderGuestStatus {
  String get label {
    switch (this) {
      case OrderGuestStatus.pending:
        return '수락대기';
      case OrderGuestStatus.paid:
        return '주문 접수';
      case OrderGuestStatus.accepted:
        return '픽업 대기';
      case OrderGuestStatus.rejected:
        return '매장 취소';
      case OrderGuestStatus.completed:
        return '픽업 완료';
      case OrderGuestStatus.canceled:
        return '본인 취소';
      case OrderGuestStatus.failed:
        return '주문 실패';
    }
  }

  Color get color {
    switch (this) {
      case OrderGuestStatus.paid:
        return MgColorScheme.primary;
      case OrderGuestStatus.accepted:
        return MgColorScheme.secondary;
      case OrderGuestStatus.pending:
      case OrderGuestStatus.completed:
      case OrderGuestStatus.canceled:
      case OrderGuestStatus.rejected:
      case OrderGuestStatus.failed:
        return MgColorScheme.gray5;
    }
  }
}
