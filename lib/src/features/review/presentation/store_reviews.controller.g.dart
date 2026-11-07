// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_reviews.controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storeReviewsHash() => r'7fa083424715c45287d9dcb0aa0b569903bb4926';

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

abstract class _$StoreReviews
    extends BuildlessAutoDisposeAsyncNotifier<StoreReviewsState> {
  late final String goodsId;

  FutureOr<StoreReviewsState> build(String goodsId);
}

/// See also [StoreReviews].
@ProviderFor(StoreReviews)
const storeReviewsProvider = StoreReviewsFamily();

/// See also [StoreReviews].
class StoreReviewsFamily extends Family<AsyncValue<StoreReviewsState>> {
  /// See also [StoreReviews].
  const StoreReviewsFamily();

  /// See also [StoreReviews].
  StoreReviewsProvider call(String goodsId) {
    return StoreReviewsProvider(goodsId);
  }

  @override
  StoreReviewsProvider getProviderOverride(
    covariant StoreReviewsProvider provider,
  ) {
    return call(provider.goodsId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'storeReviewsProvider';
}

/// See also [StoreReviews].
class StoreReviewsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<StoreReviews, StoreReviewsState> {
  /// See also [StoreReviews].
  StoreReviewsProvider(String goodsId)
    : this._internal(
        () => StoreReviews()..goodsId = goodsId,
        from: storeReviewsProvider,
        name: r'storeReviewsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$storeReviewsHash,
        dependencies: StoreReviewsFamily._dependencies,
        allTransitiveDependencies:
            StoreReviewsFamily._allTransitiveDependencies,
        goodsId: goodsId,
      );

  StoreReviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.goodsId,
  }) : super.internal();

  final String goodsId;

  @override
  FutureOr<StoreReviewsState> runNotifierBuild(
    covariant StoreReviews notifier,
  ) {
    return notifier.build(goodsId);
  }

  @override
  Override overrideWith(StoreReviews Function() create) {
    return ProviderOverride(
      origin: this,
      override: StoreReviewsProvider._internal(
        () => create()..goodsId = goodsId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        goodsId: goodsId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StoreReviews, StoreReviewsState>
  createElement() {
    return _StoreReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoreReviewsProvider && other.goodsId == goodsId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, goodsId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StoreReviewsRef
    on AutoDisposeAsyncNotifierProviderRef<StoreReviewsState> {
  /// The parameter `goodsId` of this provider.
  String get goodsId;
}

class _StoreReviewsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<StoreReviews, StoreReviewsState>
    with StoreReviewsRef {
  _StoreReviewsProviderElement(super.provider);

  @override
  String get goodsId => (origin as StoreReviewsProvider).goodsId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
