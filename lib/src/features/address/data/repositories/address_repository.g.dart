// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addressRepositoryHash() => r'd727148e8c6ef44dd49d49fb9c0a8dbb55a893b3';

/// See also [addressRepository].
@ProviderFor(addressRepository)
final addressRepositoryProvider =
    AutoDisposeProvider<AddressRepository>.internal(
      addressRepository,
      name: r'addressRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$addressRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AddressRepositoryRef = AutoDisposeProviderRef<AddressRepository>;
String _$serviceAddressesHash() => r'1d21b25f8cae0e7f3f6732dc2b5518b0d6dd4159';

/// See also [serviceAddresses].
@ProviderFor(serviceAddresses)
final serviceAddressesProvider =
    AutoDisposeFutureProvider<List<Address>>.internal(
      serviceAddresses,
      name: r'serviceAddressesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$serviceAddressesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServiceAddressesRef = AutoDisposeFutureProviderRef<List<Address>>;
String _$regionCitiesHash() => r'853b4fd97ceee3dadafe1dfa9072cd879e1701dc';

/// See also [regionCities].
@ProviderFor(regionCities)
final regionCitiesProvider = AutoDisposeFutureProvider<List<String>>.internal(
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
typedef RegionCitiesRef = AutoDisposeFutureProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
