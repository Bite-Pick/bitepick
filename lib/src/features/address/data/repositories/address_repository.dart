import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_repository.g.dart';

class AddressRepository {
  final Ref ref;
  late final Dio _dio;

  AddressRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<List<Address>> getServiceAddresses() async {
    final res = await _dio.get('/v1/service-areas');
    // talker.debug('Service Areas Response: ${res.data}');
    if (res.data['status'] != 'OK') return [];
    final serviceAddressesData = res.data['data'] as List?;
    if (serviceAddressesData == null) return [];
    return serviceAddressesData
        .map((json) => Address.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
AddressRepository addressRepository(Ref ref) {
  return AddressRepository(ref);
}

@riverpod
Future<List<Address>> serviceAddresses(Ref ref) {
  return ref.read(addressRepositoryProvider).getServiceAddresses();
}
