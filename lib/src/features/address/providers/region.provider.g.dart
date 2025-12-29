// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$regionCitiesHash() => r'3abc7f4c5f82a20b734676039ebccc0ac54b6de5';

/// City DTO를 Region으로 변환
///
/// Copied from [regionCities].
@ProviderFor(regionCities)
final regionCitiesProvider = AutoDisposeFutureProvider<List<Region>>.internal(
  regionCities,
  name: r'regionCitiesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$regionCitiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RegionCitiesRef = AutoDisposeFutureProviderRef<List<Region>>;
String _$regionDistrictsHash() => r'f4e3b23a1fa92a4dc1b21980572203d929703ded';

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

/// District DTO를 Region으로 변환
///
/// Copied from [regionDistricts].
@ProviderFor(regionDistricts)
const regionDistrictsProvider = RegionDistrictsFamily();

/// District DTO를 Region으로 변환
///
/// Copied from [regionDistricts].
class RegionDistrictsFamily extends Family<AsyncValue<List<Region>>> {
  /// District DTO를 Region으로 변환
  ///
  /// Copied from [regionDistricts].
  const RegionDistrictsFamily();

  /// District DTO를 Region으로 변환
  ///
  /// Copied from [regionDistricts].
  RegionDistrictsProvider call(String cityName) {
    return RegionDistrictsProvider(cityName);
  }

  @override
  RegionDistrictsProvider getProviderOverride(
    covariant RegionDistrictsProvider provider,
  ) {
    return call(provider.cityName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'regionDistrictsProvider';
}

/// District DTO를 Region으로 변환
///
/// Copied from [regionDistricts].
class RegionDistrictsProvider extends AutoDisposeFutureProvider<List<Region>> {
  /// District DTO를 Region으로 변환
  ///
  /// Copied from [regionDistricts].
  RegionDistrictsProvider(String cityName)
    : this._internal(
        (ref) => regionDistricts(ref as RegionDistrictsRef, cityName),
        from: regionDistrictsProvider,
        name: r'regionDistrictsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$regionDistrictsHash,
        dependencies: RegionDistrictsFamily._dependencies,
        allTransitiveDependencies:
            RegionDistrictsFamily._allTransitiveDependencies,
        cityName: cityName,
      );

  RegionDistrictsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityName,
  }) : super.internal();

  final String cityName;

  @override
  Override overrideWith(
    FutureOr<List<Region>> Function(RegionDistrictsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegionDistrictsProvider._internal(
        (ref) => create(ref as RegionDistrictsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityName: cityName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Region>> createElement() {
    return _RegionDistrictsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegionDistrictsProvider && other.cityName == cityName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegionDistrictsRef on AutoDisposeFutureProviderRef<List<Region>> {
  /// The parameter `cityName` of this provider.
  String get cityName;
}

class _RegionDistrictsProviderElement
    extends AutoDisposeFutureProviderElement<List<Region>>
    with RegionDistrictsRef {
  _RegionDistrictsProviderElement(super.provider);

  @override
  String get cityName => (origin as RegionDistrictsProvider).cityName;
}

String _$regionTownsHash() => r'6fbe03c05c3f0d962d6882a752fa408cd7d15d38';

/// Town DTO를 Region으로 변환
///
/// Copied from [regionTowns].
@ProviderFor(regionTowns)
const regionTownsProvider = RegionTownsFamily();

/// Town DTO를 Region으로 변환
///
/// Copied from [regionTowns].
class RegionTownsFamily extends Family<AsyncValue<List<Region>>> {
  /// Town DTO를 Region으로 변환
  ///
  /// Copied from [regionTowns].
  const RegionTownsFamily();

  /// Town DTO를 Region으로 변환
  ///
  /// Copied from [regionTowns].
  RegionTownsProvider call({
    required String cityName,
    required String districtName,
  }) {
    return RegionTownsProvider(cityName: cityName, districtName: districtName);
  }

  @override
  RegionTownsProvider getProviderOverride(
    covariant RegionTownsProvider provider,
  ) {
    return call(
      cityName: provider.cityName,
      districtName: provider.districtName,
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
  String? get name => r'regionTownsProvider';
}

/// Town DTO를 Region으로 변환
///
/// Copied from [regionTowns].
class RegionTownsProvider extends AutoDisposeFutureProvider<List<Region>> {
  /// Town DTO를 Region으로 변환
  ///
  /// Copied from [regionTowns].
  RegionTownsProvider({required String cityName, required String districtName})
    : this._internal(
        (ref) => regionTowns(
          ref as RegionTownsRef,
          cityName: cityName,
          districtName: districtName,
        ),
        from: regionTownsProvider,
        name: r'regionTownsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$regionTownsHash,
        dependencies: RegionTownsFamily._dependencies,
        allTransitiveDependencies: RegionTownsFamily._allTransitiveDependencies,
        cityName: cityName,
        districtName: districtName,
      );

  RegionTownsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityName,
    required this.districtName,
  }) : super.internal();

  final String cityName;
  final String districtName;

  @override
  Override overrideWith(
    FutureOr<List<Region>> Function(RegionTownsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegionTownsProvider._internal(
        (ref) => create(ref as RegionTownsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityName: cityName,
        districtName: districtName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Region>> createElement() {
    return _RegionTownsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegionTownsProvider &&
        other.cityName == cityName &&
        other.districtName == districtName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityName.hashCode);
    hash = _SystemHash.combine(hash, districtName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegionTownsRef on AutoDisposeFutureProviderRef<List<Region>> {
  /// The parameter `cityName` of this provider.
  String get cityName;

  /// The parameter `districtName` of this provider.
  String get districtName;
}

class _RegionTownsProviderElement
    extends AutoDisposeFutureProviderElement<List<Region>>
    with RegionTownsRef {
  _RegionTownsProviderElement(super.provider);

  @override
  String get cityName => (origin as RegionTownsProvider).cityName;
  @override
  String get districtName => (origin as RegionTownsProvider).districtName;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
