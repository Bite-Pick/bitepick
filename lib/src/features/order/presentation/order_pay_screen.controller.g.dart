// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_pay_screen.controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderPayScreenControllerHash() =>
    r'b93aa75845d21417358ea5f19f5843d97b93c79c';

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

abstract class _$OrderPayScreenController extends BuildlessNotifier<OrderInfo> {
  late final String storeId;

  OrderInfo build(String storeId);
}

/// See also [OrderPayScreenController].
@ProviderFor(OrderPayScreenController)
const orderPayScreenControllerProvider = OrderPayScreenControllerFamily();

/// See also [OrderPayScreenController].
class OrderPayScreenControllerFamily extends Family<OrderInfo> {
  /// See also [OrderPayScreenController].
  const OrderPayScreenControllerFamily();

  /// See also [OrderPayScreenController].
  OrderPayScreenControllerProvider call(String storeId) {
    return OrderPayScreenControllerProvider(storeId);
  }

  @override
  OrderPayScreenControllerProvider getProviderOverride(
    covariant OrderPayScreenControllerProvider provider,
  ) {
    return call(provider.storeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderPayScreenControllerProvider';
}

/// See also [OrderPayScreenController].
class OrderPayScreenControllerProvider
    extends NotifierProviderImpl<OrderPayScreenController, OrderInfo> {
  /// See also [OrderPayScreenController].
  OrderPayScreenControllerProvider(String storeId)
    : this._internal(
        () => OrderPayScreenController()..storeId = storeId,
        from: orderPayScreenControllerProvider,
        name: r'orderPayScreenControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$orderPayScreenControllerHash,
        dependencies: OrderPayScreenControllerFamily._dependencies,
        allTransitiveDependencies:
            OrderPayScreenControllerFamily._allTransitiveDependencies,
        storeId: storeId,
      );

  OrderPayScreenControllerProvider._internal(
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
  OrderInfo runNotifierBuild(covariant OrderPayScreenController notifier) {
    return notifier.build(storeId);
  }

  @override
  Override overrideWith(OrderPayScreenController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrderPayScreenControllerProvider._internal(
        () => create()..storeId = storeId,
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
  NotifierProviderElement<OrderPayScreenController, OrderInfo> createElement() {
    return _OrderPayScreenControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderPayScreenControllerProvider &&
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
mixin OrderPayScreenControllerRef on NotifierProviderRef<OrderInfo> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _OrderPayScreenControllerProviderElement
    extends NotifierProviderElement<OrderPayScreenController, OrderInfo>
    with OrderPayScreenControllerRef {
  _OrderPayScreenControllerProviderElement(super.provider);

  @override
  String get storeId => (origin as OrderPayScreenControllerProvider).storeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
