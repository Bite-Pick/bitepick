// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminRepositoryHash() => r'9ba46cdd6c393e3c6715bc23a160823ca33144a6';

/// See also [adminRepository].
@ProviderFor(adminRepository)
final adminRepositoryProvider = AutoDisposeProvider<AdminRepository>.internal(
  adminRepository,
  name: r'adminRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AdminRepositoryRef = AutoDisposeProviderRef<AdminRepository>;
String _$pendingStoreListHash() => r'43fc5955cb0a880a9cc5eb03d4865c43d860d1ab';

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

/// See also [pendingStoreList].
@ProviderFor(pendingStoreList)
const pendingStoreListProvider = PendingStoreListFamily();

/// See also [pendingStoreList].
class PendingStoreListFamily extends Family<AsyncValue<List<PendingStoreDto>>> {
  /// See also [pendingStoreList].
  const PendingStoreListFamily();

  /// See also [pendingStoreList].
  PendingStoreListProvider call({int page = 1, int size = 20}) {
    return PendingStoreListProvider(page: page, size: size);
  }

  @override
  PendingStoreListProvider getProviderOverride(
    covariant PendingStoreListProvider provider,
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
  String? get name => r'pendingStoreListProvider';
}

/// See also [pendingStoreList].
class PendingStoreListProvider
    extends AutoDisposeFutureProvider<List<PendingStoreDto>> {
  /// See also [pendingStoreList].
  PendingStoreListProvider({int page = 1, int size = 20})
    : this._internal(
        (ref) => pendingStoreList(
          ref as PendingStoreListRef,
          page: page,
          size: size,
        ),
        from: pendingStoreListProvider,
        name: r'pendingStoreListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$pendingStoreListHash,
        dependencies: PendingStoreListFamily._dependencies,
        allTransitiveDependencies:
            PendingStoreListFamily._allTransitiveDependencies,
        page: page,
        size: size,
      );

  PendingStoreListProvider._internal(
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
    FutureOr<List<PendingStoreDto>> Function(PendingStoreListRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PendingStoreListProvider._internal(
        (ref) => create(ref as PendingStoreListRef),
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
  AutoDisposeFutureProviderElement<List<PendingStoreDto>> createElement() {
    return _PendingStoreListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PendingStoreListProvider &&
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
mixin PendingStoreListRef
    on AutoDisposeFutureProviderRef<List<PendingStoreDto>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `size` of this provider.
  int get size;
}

class _PendingStoreListProviderElement
    extends AutoDisposeFutureProviderElement<List<PendingStoreDto>>
    with PendingStoreListRef {
  _PendingStoreListProviderElement(super.provider);

  @override
  int get page => (origin as PendingStoreListProvider).page;
  @override
  int get size => (origin as PendingStoreListProvider).size;
}

String _$bannerImagesHash() => r'9a25c1ad5efcafe38b5e58c472baff51aad4177f';

/// See also [bannerImages].
@ProviderFor(bannerImages)
final bannerImagesProvider =
    AutoDisposeFutureProvider<List<BannerImage>>.internal(
      bannerImages,
      name: r'bannerImagesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bannerImagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BannerImagesRef = AutoDisposeFutureProviderRef<List<BannerImage>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
