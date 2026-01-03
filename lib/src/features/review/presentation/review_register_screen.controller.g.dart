// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_register_screen.controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewRegisterScreenControllerHash() =>
    r'99c495a06f0ca0ed6a1301685a4e4b7665b692e8';

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

abstract class _$ReviewRegisterScreenController
    extends BuildlessAutoDisposeNotifier<ReviewRegisterState> {
  late final String orderGoodsId;

  ReviewRegisterState build(String orderGoodsId);
}

/// See also [ReviewRegisterScreenController].
@ProviderFor(ReviewRegisterScreenController)
const reviewRegisterScreenControllerProvider =
    ReviewRegisterScreenControllerFamily();

/// See also [ReviewRegisterScreenController].
class ReviewRegisterScreenControllerFamily extends Family<ReviewRegisterState> {
  /// See also [ReviewRegisterScreenController].
  const ReviewRegisterScreenControllerFamily();

  /// See also [ReviewRegisterScreenController].
  ReviewRegisterScreenControllerProvider call(String orderGoodsId) {
    return ReviewRegisterScreenControllerProvider(orderGoodsId);
  }

  @override
  ReviewRegisterScreenControllerProvider getProviderOverride(
    covariant ReviewRegisterScreenControllerProvider provider,
  ) {
    return call(provider.orderGoodsId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'reviewRegisterScreenControllerProvider';
}

/// See also [ReviewRegisterScreenController].
class ReviewRegisterScreenControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          ReviewRegisterScreenController,
          ReviewRegisterState
        > {
  /// See also [ReviewRegisterScreenController].
  ReviewRegisterScreenControllerProvider(String orderGoodsId)
    : this._internal(
        () => ReviewRegisterScreenController()..orderGoodsId = orderGoodsId,
        from: reviewRegisterScreenControllerProvider,
        name: r'reviewRegisterScreenControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$reviewRegisterScreenControllerHash,
        dependencies: ReviewRegisterScreenControllerFamily._dependencies,
        allTransitiveDependencies:
            ReviewRegisterScreenControllerFamily._allTransitiveDependencies,
        orderGoodsId: orderGoodsId,
      );

  ReviewRegisterScreenControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderGoodsId,
  }) : super.internal();

  final String orderGoodsId;

  @override
  ReviewRegisterState runNotifierBuild(
    covariant ReviewRegisterScreenController notifier,
  ) {
    return notifier.build(orderGoodsId);
  }

  @override
  Override overrideWith(ReviewRegisterScreenController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReviewRegisterScreenControllerProvider._internal(
        () => create()..orderGoodsId = orderGoodsId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderGoodsId: orderGoodsId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    ReviewRegisterScreenController,
    ReviewRegisterState
  >
  createElement() {
    return _ReviewRegisterScreenControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewRegisterScreenControllerProvider &&
        other.orderGoodsId == orderGoodsId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderGoodsId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReviewRegisterScreenControllerRef
    on AutoDisposeNotifierProviderRef<ReviewRegisterState> {
  /// The parameter `orderGoodsId` of this provider.
  String get orderGoodsId;
}

class _ReviewRegisterScreenControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ReviewRegisterScreenController,
          ReviewRegisterState
        >
    with ReviewRegisterScreenControllerRef {
  _ReviewRegisterScreenControllerProviderElement(super.provider);

  @override
  String get orderGoodsId =>
      (origin as ReviewRegisterScreenControllerProvider).orderGoodsId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
