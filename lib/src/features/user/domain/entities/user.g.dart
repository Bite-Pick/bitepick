// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  email: json['email'] as String,
  nickName: json['nickName'] as String,
  userRole: $enumDecode(_$UserRoleEnumMap, json['userRole']),
  providerType: $enumDecode(_$AuthProviderTypeEnumMap, json['providerType']),
  approved: $enumDecodeNullable(_$ApprovedStatusEnumMap, json['approved']),
  goodsId: json['goodsId'] as String?,
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickName': instance.nickName,
      'userRole': _$UserRoleEnumMap[instance.userRole]!,
      'providerType': _$AuthProviderTypeEnumMap[instance.providerType]!,
      'approved': _$ApprovedStatusEnumMap[instance.approved],
      'goodsId': instance.goodsId,
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'CUSTOMER',
  UserRole.owner: 'OWNER',
  UserRole.admin: 'ADMIN',
};

const _$AuthProviderTypeEnumMap = {
  AuthProviderType.NAVER: 'NAVER',
  AuthProviderType.KAKAO: 'KAKAO',
  AuthProviderType.APPLE: 'APPLE',
};

const _$ApprovedStatusEnumMap = {
  ApprovedStatus.approved: 'APPROVED',
  ApprovedStatus.rejected: 'REJECTED',
  ApprovedStatus.waiting: 'WAITING',
};
