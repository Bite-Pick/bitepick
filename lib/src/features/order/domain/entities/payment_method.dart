/// 결제 수단
enum PaymentMethod {
  easyPay('EASY_PAY', '간편결제'),
  card('CARD', '카드결제');

  final String value;
  final String displayName;

  const PaymentMethod(this.value, this.displayName);

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PaymentMethod.card,
    );
  }
}

/// 간편결제 업체
// NOTE: 현재 tosspay만 활성화
enum PaymentCompany {
  naver('NAVER', '네이버페이', 'tosspayments.naverpay'), // TODO: pgProvider 확인 필요
  kakao('KAKAO', '카카오페이', 'tosspayments.kakaopay'),
  toss('TOSS', '토스페이', 'tosspayments');

  final String key;
  final String displayName;
  final String pgProvider; // V1 API: {PG사}.{간편결제사} 형식

  const PaymentCompany(this.key, this.displayName, this.pgProvider);

  static PaymentCompany fromString(String key) {
    return PaymentCompany.values.firstWhere(
      (e) => e.key == key,
      orElse: () => PaymentCompany.naver,
    );
  }
}
