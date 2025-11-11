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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
