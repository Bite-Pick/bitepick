import 'package:magambell/src/features/store/data/repositories/store_repository.dart';
import 'package:magambell/src/features/store/domain/entities/store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store.provider.g.dart';

@Riverpod(keepAlive: true)
class StoreState extends _$StoreState {
  @override
  Future<Store?> build() async {
    return await ref.read(storeRepositoryProvider).getOwnerStore();
  }

  // 매장 정보 초기화
  void clearStore() => state = AsyncValue.data(null);
}
