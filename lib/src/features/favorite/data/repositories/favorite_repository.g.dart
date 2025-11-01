// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteRepositoryHash() =>
    r'4db8ff3394d8f2a3e23519de3cb7972abf3044aa';

/// See also [favoriteRepository].
@ProviderFor(favoriteRepository)
final favoriteRepositoryProvider =
    AutoDisposeProvider<FavoriteRepository>.internal(
      favoriteRepository,
      name: r'favoriteRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoriteRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteRepositoryRef = AutoDisposeProviderRef<FavoriteRepository>;
String _$favoriteHash() => r'937b2ee0bcdc32d87bc79feeafbad815674071ea';

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

/// See also [favorite].
@ProviderFor(favorite)
const favoriteProvider = FavoriteFamily();

/// See also [favorite].
class FavoriteFamily extends Family<AsyncValue<bool?>> {
  /// See also [favorite].
  const FavoriteFamily();

  /// See also [favorite].
  FavoriteProvider call({required String storeId}) {
    return FavoriteProvider(storeId: storeId);
  }

  @override
  FavoriteProvider getProviderOverride(covariant FavoriteProvider provider) {
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
  String? get name => r'favoriteProvider';
}

/// See also [favorite].
class FavoriteProvider extends AutoDisposeFutureProvider<bool?> {
  /// See also [favorite].
  FavoriteProvider({required String storeId})
    : this._internal(
        (ref) => favorite(ref as FavoriteRef, storeId: storeId),
        from: favoriteProvider,
        name: r'favoriteProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$favoriteHash,
        dependencies: FavoriteFamily._dependencies,
        allTransitiveDependencies: FavoriteFamily._allTransitiveDependencies,
        storeId: storeId,
      );

  FavoriteProvider._internal(
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
  Override overrideWith(FutureOr<bool?> Function(FavoriteRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: FavoriteProvider._internal(
        (ref) => create(ref as FavoriteRef),
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
  AutoDisposeFutureProviderElement<bool?> createElement() {
    return _FavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoriteProvider && other.storeId == storeId;
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
mixin FavoriteRef on AutoDisposeFutureProviderRef<bool?> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _FavoriteProviderElement extends AutoDisposeFutureProviderElement<bool?>
    with FavoriteRef {
  _FavoriteProviderElement(super.provider);

  @override
  String get storeId => (origin as FavoriteProvider).storeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
