import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  @JsonValue('CUSTOMER')
  customer('CUSTOMER', '일반 사용자'),
  @JsonValue('OWNER')
  owner('OWNER', '사장님'),
  @JsonValue('ADMIN')
  admin('ADMIN', '관리자');

  const UserRole(this.value, this.label);

  final String value;
  final String label;
}
