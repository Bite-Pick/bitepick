enum OrderRejectReason {
  cookingDelay('COOKING_DELAY', '조리 지연'),
  outOfStock('OUT_OF_STOCK', '재료 소진'),
  // undeliverableArea('UNDELIVERABLE_AREA', '배달 불가 지역'),
  storeIssue('STORE_ISSUE', '가게 사정');
  // system('SYSTEM', '시스템 자동 거절');

  const OrderRejectReason(this.code, this.description);

  final String code;
  final String description;

  // Optional: A method to get the enum from its code string
  static OrderRejectReason? fromCode(String code) {
    for (var reason in OrderRejectReason.values) {
      if (reason.code == code) {
        return reason;
      }
    }
    return null;
  }
}
