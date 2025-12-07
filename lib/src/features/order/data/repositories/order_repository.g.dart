// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'c5571bed3ef6cc72e60a84bd997ac960798248f9';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = AutoDisposeProvider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrderRepositoryRef = AutoDisposeProviderRef<OrderRepository>;
String _$storeOrdersHash() => r'04dbd43356e06d728d465d48be645330f04914c7';

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

/// See also [storeOrders].
@ProviderFor(storeOrders)
const storeOrdersProvider = StoreOrdersFamily();

/// See also [storeOrders].
class StoreOrdersFamily extends Family<AsyncValue<List<OrderOwner>>> {
  /// See also [storeOrders].
  const StoreOrdersFamily();

  /// See also [storeOrders].
  StoreOrdersProvider call({
    int page = 1,
    int size = 10,
    OrderOwnerStatus? orderStatus,
  }) {
    return StoreOrdersProvider(
      page: page,
      size: size,
      orderStatus: orderStatus,
    );
  }

  @override
  StoreOrdersProvider getProviderOverride(
    covariant StoreOrdersProvider provider,
  ) {
    return call(
      page: provider.page,
      size: provider.size,
      orderStatus: provider.orderStatus,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'storeOrdersProvider';
}

/// See also [storeOrders].
class StoreOrdersProvider extends AutoDisposeFutureProvider<List<OrderOwner>> {
  /// See also [storeOrders].
  StoreOrdersProvider({
    int page = 1,
    int size = 10,
    OrderOwnerStatus? orderStatus,
  }) : this._internal(
         (ref) => storeOrders(
           ref as StoreOrdersRef,
           page: page,
           size: size,
           orderStatus: orderStatus,
         ),
         from: storeOrdersProvider,
         name: r'storeOrdersProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$storeOrdersHash,
         dependencies: StoreOrdersFamily._dependencies,
         allTransitiveDependencies:
             StoreOrdersFamily._allTransitiveDependencies,
         page: page,
         size: size,
         orderStatus: orderStatus,
       );

  StoreOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.size,
    required this.orderStatus,
  }) : super.internal();

  final int page;
  final int size;
  final OrderOwnerStatus? orderStatus;

  @override
  Override overrideWith(
    FutureOr<List<OrderOwner>> Function(StoreOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StoreOrdersProvider._internal(
        (ref) => create(ref as StoreOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        size: size,
        orderStatus: orderStatus,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrderOwner>> createElement() {
    return _StoreOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoreOrdersProvider &&
        other.page == page &&
        other.size == size &&
        other.orderStatus == orderStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);
    hash = _SystemHash.combine(hash, orderStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StoreOrdersRef on AutoDisposeFutureProviderRef<List<OrderOwner>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `size` of this provider.
  int get size;

  /// The parameter `orderStatus` of this provider.
  OrderOwnerStatus? get orderStatus;
}

class _StoreOrdersProviderElement
    extends AutoDisposeFutureProviderElement<List<OrderOwner>>
    with StoreOrdersRef {
  _StoreOrdersProviderElement(super.provider);

  @override
  int get page => (origin as StoreOrdersProvider).page;
  @override
  int get size => (origin as StoreOrdersProvider).size;
  @override
  OrderOwnerStatus? get orderStatus =>
      (origin as StoreOrdersProvider).orderStatus;
}

String _$userOrdersHash() => r'd8f64f88b017f934afa9702faed5f00d0a082bed';

/// See also [userOrders].
@ProviderFor(userOrders)
const userOrdersProvider = UserOrdersFamily();

/// See also [userOrders].
class UserOrdersFamily extends Family<AsyncValue<List<OrderListDTO>>> {
  /// See also [userOrders].
  const UserOrdersFamily();

  /// See also [userOrders].
  UserOrdersProvider call({int page = 1, int size = 10}) {
    return UserOrdersProvider(page: page, size: size);
  }

  @override
  UserOrdersProvider getProviderOverride(
    covariant UserOrdersProvider provider,
  ) {
    return call(page: provider.page, size: provider.size);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userOrdersProvider';
}

/// See also [userOrders].
class UserOrdersProvider extends AutoDisposeFutureProvider<List<OrderListDTO>> {
  /// See also [userOrders].
  UserOrdersProvider({int page = 1, int size = 10})
    : this._internal(
        (ref) => userOrders(ref as UserOrdersRef, page: page, size: size),
        from: userOrdersProvider,
        name: r'userOrdersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userOrdersHash,
        dependencies: UserOrdersFamily._dependencies,
        allTransitiveDependencies: UserOrdersFamily._allTransitiveDependencies,
        page: page,
        size: size,
      );

  UserOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.size,
  }) : super.internal();

  final int page;
  final int size;

  @override
  Override overrideWith(
    FutureOr<List<OrderListDTO>> Function(UserOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserOrdersProvider._internal(
        (ref) => create(ref as UserOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        size: size,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrderListDTO>> createElement() {
    return _UserOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserOrdersProvider &&
        other.page == page &&
        other.size == size;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserOrdersRef on AutoDisposeFutureProviderRef<List<OrderListDTO>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `size` of this provider.
  int get size;
}

class _UserOrdersProviderElement
    extends AutoDisposeFutureProviderElement<List<OrderListDTO>>
    with UserOrdersRef {
  _UserOrdersProviderElement(super.provider);

  @override
  int get page => (origin as UserOrdersProvider).page;
  @override
  int get size => (origin as UserOrdersProvider).size;
}

String _$userOrderDetailHash() => r'6bd315f64a7b86ba731708c97aa15bb5fed014f1';

/// See also [userOrderDetail].
@ProviderFor(userOrderDetail)
const userOrderDetailProvider = UserOrderDetailFamily();

/// See also [userOrderDetail].
class UserOrderDetailFamily extends Family<AsyncValue<OrderDetailDTO?>> {
  /// See also [userOrderDetail].
  const UserOrderDetailFamily();

  /// See also [userOrderDetail].
  UserOrderDetailProvider call({required String orderId}) {
    return UserOrderDetailProvider(orderId: orderId);
  }

  @override
  UserOrderDetailProvider getProviderOverride(
    covariant UserOrderDetailProvider provider,
  ) {
    return call(orderId: provider.orderId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userOrderDetailProvider';
}

/// See also [userOrderDetail].
class UserOrderDetailProvider
    extends AutoDisposeFutureProvider<OrderDetailDTO?> {
  /// See also [userOrderDetail].
  UserOrderDetailProvider({required String orderId})
    : this._internal(
        (ref) => userOrderDetail(ref as UserOrderDetailRef, orderId: orderId),
        from: userOrderDetailProvider,
        name: r'userOrderDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userOrderDetailHash,
        dependencies: UserOrderDetailFamily._dependencies,
        allTransitiveDependencies:
            UserOrderDetailFamily._allTransitiveDependencies,
        orderId: orderId,
      );

  UserOrderDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<OrderDetailDTO?> Function(UserOrderDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserOrderDetailProvider._internal(
        (ref) => create(ref as UserOrderDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderDetailDTO?> createElement() {
    return _UserOrderDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserOrderDetailProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserOrderDetailRef on AutoDisposeFutureProviderRef<OrderDetailDTO?> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _UserOrderDetailProviderElement
    extends AutoDisposeFutureProviderElement<OrderDetailDTO?>
    with UserOrderDetailRef {
  _UserOrderDetailProviderElement(super.provider);

  @override
  String get orderId => (origin as UserOrderDetailProvider).orderId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
