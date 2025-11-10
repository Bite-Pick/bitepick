import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

enum OrderStatus {
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

extension OrderStatusExt on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return '수락대기';
      case OrderStatus.paid:
        return '주문 접수';
      case OrderStatus.accepted:
        return '픽업 대기';
      case OrderStatus.rejected:
        return '매장 취소';
      case OrderStatus.completed:
        return '픽업 완료';
      case OrderStatus.canceled:
        return '본인 취소';
      case OrderStatus.failed:
        return '주문 실패';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.paid:
        return MgColorScheme.primary;
      case OrderStatus.accepted:
        return MgColorScheme.secondary;
      case OrderStatus.completed:
        return MgColorScheme.gray5;
      case OrderStatus.pending:
      case OrderStatus.rejected:
      case OrderStatus.canceled:
      case OrderStatus.failed:
        return MgColorScheme.subpointRed;
    }
  }
}
