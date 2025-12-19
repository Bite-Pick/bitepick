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
String _$serviceAddressesHash() => r'4bf66e5955bff72de2b60ca3b2fbd2e09dd25e31';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
