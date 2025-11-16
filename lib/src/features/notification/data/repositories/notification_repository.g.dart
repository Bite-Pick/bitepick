// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationRepositoryHash() =>
    r'3f8f70c8cd9f72931a029a85f08bc993092970a0';

/// Repository Provider
///
/// Copied from [notificationRepository].
@ProviderFor(notificationRepository)
final notificationRepositoryProvider =
    AutoDisposeProvider<NotificationRepository>.internal(
      notificationRepository,
      name: r'notificationRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationRepositoryRef =
    AutoDisposeProviderRef<NotificationRepository>;
String _$storeNotificationSubscribedHash() =>
    r'a3b0bc2ee27e205f589c45775e36d224cac2bf10';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 알림 상태 조회용 Provider
///
/// 사용 예:
/// ```dart
/// final subscribedAsync = ref.watch(storeNotificationSubscribedProvider(storeId: storeId));
/// ```
///
/// Copied from [storeNotificationSubscribed].
@ProviderFor(storeNotificationSubscribed)
const storeNotificationSubscribedProvider = StoreNotificationSubscribedFamily();

/// 알림 상태 조회용 Provider
///
/// 사용 예:
/// ```dart
/// final subscribedAsync = ref.watch(storeNotificationSubscribedProvider(storeId: storeId));
/// ```
///
/// Copied from [storeNotificationSubscribed].
class StoreNotificationSubscribedFamily extends Family<AsyncValue<bool>> {
  /// 알림 상태 조회용 Provider
  ///
  /// 사용 예:
  /// ```dart
  /// final subscribedAsync = ref.watch(storeNotificationSubscribedProvider(storeId: storeId));
  /// ```
  ///
  /// Copied from [storeNotificationSubscribed].
  const StoreNotificationSubscribedFamily();

  /// 알림 상태 조회용 Provider
  ///
  /// 사용 예:
  /// ```dart
  /// final subscribedAsync = ref.watch(storeNotificationSubscribedProvider(storeId: storeId));
  /// ```
  ///
  /// Copied from [storeNotificationSubscribed].
  StoreNotificationSubscribedProvider call({required String storeId}) {
    return StoreNotificationSubscribedProvider(storeId: storeId);
  }

  @override
  StoreNotificationSubscribedProvider getProviderOverride(
    covariant StoreNotificationSubscribedProvider provider,
  ) {
    return call(storeId: provider.storeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'storeNotificationSubscribedProvider';
}

/// 알림 상태 조회용 Provider
///
/// 사용 예:
/// ```dart
/// final subscribedAsync = ref.watch(storeNotificationSubscribedProvider(storeId: storeId));
/// ```
///
/// Copied from [storeNotificationSubscribed].
class StoreNotificationSubscribedProvider
    extends AutoDisposeFutureProvider<bool> {
  /// 알림 상태 조회용 Provider
  ///
  /// 사용 예:
  /// ```dart
  /// final subscribedAsync = ref.watch(storeNotificationSubscribedProvider(storeId: storeId));
  /// ```
  ///
  /// Copied from [storeNotificationSubscribed].
  StoreNotificationSubscribedProvider({required String storeId})
    : this._internal(
        (ref) => storeNotificationSubscribed(
          ref as StoreNotificationSubscribedRef,
          storeId: storeId,
        ),
        from: storeNotificationSubscribedProvider,
        name: r'storeNotificationSubscribedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$storeNotificationSubscribedHash,
        dependencies: StoreNotificationSubscribedFamily._dependencies,
        allTransitiveDependencies:
            StoreNotificationSubscribedFamily._allTransitiveDependencies,
        storeId: storeId,
      );

  StoreNotificationSubscribedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storeId,
  }) : super.internal();

  final String storeId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(StoreNotificationSubscribedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StoreNotificationSubscribedProvider._internal(
        (ref) => create(ref as StoreNotificationSubscribedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storeId: storeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _StoreNotificationSubscribedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoreNotificationSubscribedProvider &&
        other.storeId == storeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StoreNotificationSubscribedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _StoreNotificationSubscribedProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with StoreNotificationSubscribedRef {
  _StoreNotificationSubscribedProviderElement(super.provider);

  @override
  String get storeId => (origin as StoreNotificationSubscribedProvider).storeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
