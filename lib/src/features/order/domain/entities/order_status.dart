import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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
      case OrderStatus.pending:
        return Color(0xffFFE7B3);
      case OrderStatus.paid:
        return Color(0xffCDE3FF);
      case OrderStatus.accepted:
        return Color(0xffD7F3D4);
      case OrderStatus.rejected:
      case OrderStatus.canceled:
      case OrderStatus.failed:
        return Color(0xffEF444D);
      case OrderStatus.completed:
        return Color(0xffE2E2E2);
    }
  }
}
