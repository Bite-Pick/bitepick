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
}
