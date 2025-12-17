import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/network/api_client.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';
import 'package:magambell/src/features/address/domain/entities/address.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_repository.g.dart';

class AddressRepository {
  final Ref ref;
  late final Dio _dio;

  AddressRepository(this.ref) {
    _dio = ref.read(apiClientProvider);
  }

  Future<List<Address>> getServiceAreas() async {
    final res = await _dio.get('/v1/service-areas');
    talker.debug('Service Areas Response: ${res.data}');
    return serviceAreas;
    // if(res.data)
    // return Area.fromJson(res.data);
  }
}

@riverpod
AddressRepository addressRepository(Ref ref) {
  return AddressRepository(ref);
}

@riverpod
Future<List<Address>> serviceAddresses(Ref ref) {
  return ref.read(addressRepositoryProvider).getServiceAreas();
}
