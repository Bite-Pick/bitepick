import 'package:intl/intl.dart';

extension PriceExtension on num {
  /// 숫자를 대한민국 원화(KRW) 형식의 문자열로 변환합니다.
  /// 예: 1000 -> 1,000
  String toPrice() {
    final formatter = NumberFormat.decimalPattern('ko_KR');
    return formatter.format(this);
  }
}
