import 'package:json_annotation/json_annotation.dart';

enum SignupReferralSource {
  @JsonValue('INSTAGRAM')
  instagram('INSTAGRAM', '인스타그램'),
  @JsonValue('THREADS')
  threads('THREADS', '스레드'),
  @JsonValue('REFERRAL')
  referral('REFERRAL', '지인 추천'),
  @JsonValue('SEARCH')
  search('SEARCH', '검색'),
  @JsonValue('ETC')
  etc('ETC', '기타');

  const SignupReferralSource(this.value, this.label);

  final String value;
  final String label;
}
