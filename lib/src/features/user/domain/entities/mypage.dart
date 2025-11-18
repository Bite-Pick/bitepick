import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage.freezed.dart';
part 'mypage.g.dart';

@freezed
class Mypage with _$Mypage {
  const factory Mypage({
    required int purchaseCount,
    required int savedKg,
    required int savedPrice,
  }) = _Mypage;

  factory Mypage.fromJson(Map<String, dynamic> json) => _$MypageFromJson(json);
}
