import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// 시간 포맷
  DateTime? toDateTime(String dateTimeFormatString) {
    return DateTime.tryParse(dateTimeFormatString);
  }

  String format(String format) {
    return DateFormat(format).format(this);
  }

  String get time {
    return DateFormat("EEEE").format(this);
  }

  /// HH:mm 형식으로 변환
  String toTime() {
    return DateFormat('HH:mm').format(this);
  }

  /// HH:mm 형식으로 변환
  String toDate() {
    return DateFormat('yy.MM.dd').format(this);
  }

  String toLongDate() {
    return DateFormat('yyyy.MM.dd HH:mm').format(this);
  }
}

extension StringDateTimeExtension on String {
  /// String을 DateTime으로 파싱
  String? convertTime() {
    return DateTime.tryParse(this)?.toTime();
  }

  String? convertDate({bool isLong = false}) {
    return isLong
        ? DateTime.tryParse(this)?.toLongDate()
        : DateTime.tryParse(this)?.toDate();
  }
}
