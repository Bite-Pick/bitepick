enum SortType {
  recentDesc('RECENT_DESC', '기본순'),
  priceAsc('PRICE_ASC', '가격 낮은순'),
  distanceAsc('DISTANCE_ASC', '가까운 거리순'),
  ratingDesc('POPULAR_DESC', '리뷰많은순');

  const SortType(this.value, this.name);
  final String value;
  final String name;
}
