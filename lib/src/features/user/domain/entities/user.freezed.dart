// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get email => throw _privateConstructorUsedError;
  String get nickName => throw _privateConstructorUsedError;
  UserRole get userRole => throw _privateConstructorUsedError;
  AuthProviderType get providerType => throw _privateConstructorUsedError;
  ApprovedStatus? get approved => throw _privateConstructorUsedError;
  String? get goodsId => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String email,
    String nickName,
    UserRole userRole,
    AuthProviderType providerType,
    ApprovedStatus? approved,
    String? goodsId,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? nickName = null,
    Object? userRole = null,
    Object? providerType = null,
    Object? approved = freezed,
    Object? goodsId = freezed,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            nickName: null == nickName
                ? _value.nickName
                : nickName // ignore: cast_nullable_to_non_nullable
                      as String,
            userRole: null == userRole
                ? _value.userRole
                : userRole // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            providerType: null == providerType
                ? _value.providerType
                : providerType // ignore: cast_nullable_to_non_nullable
                      as AuthProviderType,
            approved: freezed == approved
                ? _value.approved
                : approved // ignore: cast_nullable_to_non_nullable
                      as ApprovedStatus?,
            goodsId: freezed == goodsId
                ? _value.goodsId
                : goodsId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String email,
    String nickName,
    UserRole userRole,
    AuthProviderType providerType,
    ApprovedStatus? approved,
    String? goodsId,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? nickName = null,
    Object? userRole = null,
    Object? providerType = null,
    Object? approved = freezed,
    Object? goodsId = freezed,
  }) {
    return _then(
      _$UserImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        nickName: null == nickName
            ? _value.nickName
            : nickName // ignore: cast_nullable_to_non_nullable
                  as String,
        userRole: null == userRole
            ? _value.userRole
            : userRole // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        providerType: null == providerType
            ? _value.providerType
            : providerType // ignore: cast_nullable_to_non_nullable
                  as AuthProviderType,
        approved: freezed == approved
            ? _value.approved
            : approved // ignore: cast_nullable_to_non_nullable
                  as ApprovedStatus?,
        goodsId: freezed == goodsId
            ? _value.goodsId
            : goodsId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl({
    required this.email,
    required this.nickName,
    required this.userRole,
    required this.providerType,
    this.approved,
    this.goodsId,
  }) : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String email;
  @override
  final String nickName;
  @override
  final UserRole userRole;
  @override
  final AuthProviderType providerType;
  @override
  final ApprovedStatus? approved;
  @override
  final String? goodsId;

  @override
  String toString() {
    return 'User(email: $email, nickName: $nickName, userRole: $userRole, providerType: $providerType, approved: $approved, goodsId: $goodsId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole) &&
            (identical(other.providerType, providerType) ||
                other.providerType == providerType) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.goodsId, goodsId) || other.goodsId == goodsId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    email,
    nickName,
    userRole,
    providerType,
    approved,
    goodsId,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User extends User {
  const factory _User({
    required final String email,
    required final String nickName,
    required final UserRole userRole,
    required final AuthProviderType providerType,
    final ApprovedStatus? approved,
    final String? goodsId,
  }) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get email;
  @override
  String get nickName;
  @override
  UserRole get userRole;
  @override
  AuthProviderType get providerType;
  @override
  ApprovedStatus? get approved;
  @override
  String? get goodsId;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
