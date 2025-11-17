// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storeRepositoryHash() => r'1dd846f1c7354096a70b3961e01939d4e323a535';

/// See also [storeRepository].
@ProviderFor(storeRepository)
final storeRepositoryProvider = AutoDisposeProvider<StoreRepository>.internal(
  storeRepository,
  name: r'storeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StoreRepositoryRef = AutoDisposeProviderRef<StoreRepository>;
String _$storeGoodsListHash() => r'78157a09b4141ecce8f496bdec110b34ff9217f0';

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

/// See also [storeGoodsList].
@ProviderFor(storeGoodsList)
const storeGoodsListProvider = StoreGoodsListFamily();

/// See also [storeGoodsList].
class StoreGoodsListFamily extends Family<AsyncValue<List<StoreListResponse>>> {
  /// See also [storeGoodsList].
  const StoreGoodsListFamily();

  /// See also [storeGoodsList].
  StoreGoodsListProvider call({
    required double latitude,
    required double longitude,
    String? keyword,
    SortType sortType = SortType.recentDesc,
    bool onlyAvailable = true,
    int page = 1,
    int size = 10,
  }) {
    return StoreGoodsListProvider(
      latitude: latitude,
      longitude: longitude,
      keyword: keyword,
      sortType: sortType,
      onlyAvailable: onlyAvailable,
      page: page,
      size: size,
    );
  }

  @override
  StoreGoodsListProvider getProviderOverride(
    covariant StoreGoodsListProvider provider,
  ) {
    return call(
      latitude: provider.latitude,
      longitude: provider.longitude,
      keyword: provider.keyword,
      sortType: provider.sortType,
      onlyAvailable: provider.onlyAvailable,
      page: provider.page,
      size: provider.size,
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
  String? get name => r'storeGoodsListProvider';
}

/// See also [storeGoodsList].
class StoreGoodsListProvider
    extends AutoDisposeFutureProvider<List<StoreListResponse>> {
  /// See also [storeGoodsList].
  StoreGoodsListProvider({
    required double latitude,
    required double longitude,
    String? keyword,
    SortType sortType = SortType.recentDesc,
    bool onlyAvailable = true,
    int page = 1,
    int size = 10,
  }) : this._internal(
         (ref) => storeGoodsList(
           ref as StoreGoodsListRef,
           latitude: latitude,
           longitude: longitude,
           keyword: keyword,
           sortType: sortType,
           onlyAvailable: onlyAvailable,
           page: page,
           size: size,
         ),
         from: storeGoodsListProvider,
         name: r'storeGoodsListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$storeGoodsListHash,
         dependencies: StoreGoodsListFamily._dependencies,
         allTransitiveDependencies:
             StoreGoodsListFamily._allTransitiveDependencies,
         latitude: latitude,
         longitude: longitude,
         keyword: keyword,
         sortType: sortType,
         onlyAvailable: onlyAvailable,
         page: page,
         size: size,
       );

  StoreGoodsListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.latitude,
    required this.longitude,
    required this.keyword,
    required this.sortType,
    required this.onlyAvailable,
    required this.page,
    required this.size,
  }) : super.internal();

  final double latitude;
  final double longitude;
  final String? keyword;
  final SortType sortType;
  final bool onlyAvailable;
  final int page;
  final int size;

  @override
  Override overrideWith(
    FutureOr<List<StoreListResponse>> Function(StoreGoodsListRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StoreGoodsListProvider._internal(
        (ref) => create(ref as StoreGoodsListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latitude: latitude,
        longitude: longitude,
        keyword: keyword,
        sortType: sortType,
        onlyAvailable: onlyAvailable,
        page: page,
        size: size,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StoreListResponse>> createElement() {
    return _StoreGoodsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoreGoodsListProvider &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.keyword == keyword &&
        other.sortType == sortType &&
        other.onlyAvailable == onlyAvailable &&
        other.page == page &&
        other.size == size;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latitude.hashCode);
    hash = _SystemHash.combine(hash, longitude.hashCode);
    hash = _SystemHash.combine(hash, keyword.hashCode);
    hash = _SystemHash.combine(hash, sortType.hashCode);
    hash = _SystemHash.combine(hash, onlyAvailable.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StoreGoodsListRef
    on AutoDisposeFutureProviderRef<List<StoreListResponse>> {
  /// The parameter `latitude` of this provider.
  double get latitude;

  /// The parameter `longitude` of this provider.
  double get longitude;

  /// The parameter `keyword` of this provider.
  String? get keyword;

  /// The parameter `sortType` of this provider.
  SortType get sortType;

  /// The parameter `onlyAvailable` of this provider.
  bool get onlyAvailable;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `size` of this provider.
  int get size;
}

class _StoreGoodsListProviderElement
    extends AutoDisposeFutureProviderElement<List<StoreListResponse>>
    with StoreGoodsListRef {
  _StoreGoodsListProviderElement(super.provider);

  @override
  double get latitude => (origin as StoreGoodsListProvider).latitude;
  @override
  double get longitude => (origin as StoreGoodsListProvider).longitude;
  @override
  String? get keyword => (origin as StoreGoodsListProvider).keyword;
  @override
  SortType get sortType => (origin as StoreGoodsListProvider).sortType;
  @override
  bool get onlyAvailable => (origin as StoreGoodsListProvider).onlyAvailable;
  @override
  int get page => (origin as StoreGoodsListProvider).page;
  @override
  int get size => (origin as StoreGoodsListProvider).size;
}

String _$storeGoodsDetailHash() => r'114beff048c709d20f59d89d90e27454c8b8ccac';

/// See also [storeGoodsDetail].
@ProviderFor(storeGoodsDetail)
const storeGoodsDetailProvider = StoreGoodsDetailFamily();

/// See also [storeGoodsDetail].
class StoreGoodsDetailFamily extends Family<AsyncValue<Goods?>> {
  /// See also [storeGoodsDetail].
  const StoreGoodsDetailFamily();

  /// See also [storeGoodsDetail].
  StoreGoodsDetailProvider call(String id) {
    return StoreGoodsDetailProvider(id);
  }

  @override
  StoreGoodsDetailProvider getProviderOverride(
    covariant StoreGoodsDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'storeGoodsDetailProvider';
}

/// See also [storeGoodsDetail].
class StoreGoodsDetailProvider extends AutoDisposeFutureProvider<Goods?> {
  /// See also [storeGoodsDetail].
  StoreGoodsDetailProvider(String id)
    : this._internal(
        (ref) => storeGoodsDetail(ref as StoreGoodsDetailRef, id),
        from: storeGoodsDetailProvider,
        name: r'storeGoodsDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$storeGoodsDetailHash,
        dependencies: StoreGoodsDetailFamily._dependencies,
        allTransitiveDependencies:
            StoreGoodsDetailFamily._allTransitiveDependencies,
        id: id,
      );

  StoreGoodsDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Goods?> Function(StoreGoodsDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StoreGoodsDetailProvider._internal(
        (ref) => create(ref as StoreGoodsDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Goods?> createElement() {
    return _StoreGoodsDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoreGoodsDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StoreGoodsDetailRef on AutoDisposeFutureProviderRef<Goods?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _StoreGoodsDetailProviderElement
    extends AutoDisposeFutureProviderElement<Goods?>
    with StoreGoodsDetailRef {
  _StoreGoodsDetailProviderElement(super.provider);

  @override
  String get id => (origin as StoreGoodsDetailProvider).id;
}

String _$ownerStoreHash() => r'8901a6755dd0146eb0d8c5c8e03d4509c467701e';

/// See also [ownerStore].
@ProviderFor(ownerStore)
final ownerStoreProvider = AutoDisposeFutureProvider<Store?>.internal(
  ownerStore,
  name: r'ownerStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ownerStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OwnerStoreRef = AutoDisposeFutureProviderRef<Store?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
