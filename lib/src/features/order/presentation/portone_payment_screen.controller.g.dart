// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portone_payment_screen.controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$portOnePaymentScreenControllerHash() =>
    r'57edf586480ad08ddcd3a1e772595c213a9385bf';

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

abstract class _$PortOnePaymentScreenController
    extends BuildlessAutoDisposeNotifier<PortOnePaymentState> {
  late final String storeId;
  late final String paymentId;
  late final int amount;

  PortOnePaymentState build({
    required String storeId,
    required String paymentId,
    required int amount,
  });
}

/// See also [PortOnePaymentScreenController].
@ProviderFor(PortOnePaymentScreenController)
const portOnePaymentScreenControllerProvider =
    PortOnePaymentScreenControllerFamily();

/// See also [PortOnePaymentScreenController].
class PortOnePaymentScreenControllerFamily extends Family<PortOnePaymentState> {
  /// See also [PortOnePaymentScreenController].
  const PortOnePaymentScreenControllerFamily();

  /// See also [PortOnePaymentScreenController].
  PortOnePaymentScreenControllerProvider call({
    required String storeId,
    required String paymentId,
    required int amount,
  }) {
    return PortOnePaymentScreenControllerProvider(
      storeId: storeId,
      paymentId: paymentId,
      amount: amount,
    );
  }

  @override
  PortOnePaymentScreenControllerProvider getProviderOverride(
    covariant PortOnePaymentScreenControllerProvider provider,
  ) {
    return call(
      storeId: provider.storeId,
      paymentId: provider.paymentId,
      amount: provider.amount,
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
  String? get name => r'portOnePaymentScreenControllerProvider';
}

/// See also [PortOnePaymentScreenController].
class PortOnePaymentScreenControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          PortOnePaymentScreenController,
          PortOnePaymentState
        > {
  /// See also [PortOnePaymentScreenController].
  PortOnePaymentScreenControllerProvider({
    required String storeId,
    required String paymentId,
    required int amount,
  }) : this._internal(
         () => PortOnePaymentScreenController()
           ..storeId = storeId
           ..paymentId = paymentId
           ..amount = amount,
         from: portOnePaymentScreenControllerProvider,
         name: r'portOnePaymentScreenControllerProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$portOnePaymentScreenControllerHash,
         dependencies: PortOnePaymentScreenControllerFamily._dependencies,
         allTransitiveDependencies:
             PortOnePaymentScreenControllerFamily._allTransitiveDependencies,
         storeId: storeId,
         paymentId: paymentId,
         amount: amount,
       );

  PortOnePaymentScreenControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storeId,
    required this.paymentId,
    required this.amount,
  }) : super.internal();

  final String storeId;
  final String paymentId;
  final int amount;

  @override
  PortOnePaymentState runNotifierBuild(
    covariant PortOnePaymentScreenController notifier,
  ) {
    return notifier.build(
      storeId: storeId,
      paymentId: paymentId,
      amount: amount,
    );
  }

  @override
  Override overrideWith(PortOnePaymentScreenController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PortOnePaymentScreenControllerProvider._internal(
        () => create()
          ..storeId = storeId
          ..paymentId = paymentId
          ..amount = amount,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storeId: storeId,
        paymentId: paymentId,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    PortOnePaymentScreenController,
    PortOnePaymentState
  >
  createElement() {
    return _PortOnePaymentScreenControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PortOnePaymentScreenControllerProvider &&
        other.storeId == storeId &&
        other.paymentId == paymentId &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storeId.hashCode);
    hash = _SystemHash.combine(hash, paymentId.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PortOnePaymentScreenControllerRef
    on AutoDisposeNotifierProviderRef<PortOnePaymentState> {
  /// The parameter `storeId` of this provider.
  String get storeId;

  /// The parameter `paymentId` of this provider.
  String get paymentId;

  /// The parameter `amount` of this provider.
  int get amount;
}

class _PortOnePaymentScreenControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          PortOnePaymentScreenController,
          PortOnePaymentState
        >
    with PortOnePaymentScreenControllerRef {
  _PortOnePaymentScreenControllerProviderElement(super.provider);

  @override
  String get storeId =>
      (origin as PortOnePaymentScreenControllerProvider).storeId;
  @override
  String get paymentId =>
      (origin as PortOnePaymentScreenControllerProvider).paymentId;
  @override
  int get amount => (origin as PortOnePaymentScreenControllerProvider).amount;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
