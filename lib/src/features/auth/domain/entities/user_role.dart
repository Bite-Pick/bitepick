enum UserRole {
  customer('CUSTOMER', '일반 사용자'),
  owner('OWNER', '사장님');

  const UserRole(this.value, this.label);

  final String value;
  final String label;
}
