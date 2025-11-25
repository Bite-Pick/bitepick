// TODO: pagination 활성화시 활용
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:magambell/src/features/admin/data/dtos/pending_store.dto.dart';
// import 'package:magambell/src/features/admin/data/repositories/admin_repository.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'pending_store_provider.g.dart';

// @riverpod
// class PendingStoreListNotifier extends _$PendingStoreListNotifier {
//   int _currentPage = 1;
//   static const int _pageSize = 20;
//   bool _hasMore = true;
//   bool _isLoadingMore = false;

//   bool get hasMore => _hasMore;

//   @override
//   Future<List<PendingStoreDto>> build() async {
//     _currentPage = 1;
//     _hasMore = true;
//     return _loadPage(_currentPage);
//   }

//   Future<List<PendingStoreDto>> _loadPage(int page) async {
//     final stores = await ref.read(adminRepositoryProvider).getPendingStoreList(
//           page: page,
//           size: _pageSize,
//         );

//     if (stores.length < _pageSize) {
//       _hasMore = false;
//     }

//     return stores;
//   }

//   /// 다음 페이지 로드 (무한 스크롤)
//   Future<void> loadMore() async {
//     if (_isLoadingMore || !_hasMore) return;

//     _isLoadingMore = true;
//     _currentPage++;

//     try {
//       final currentStores = state.valueOrNull ?? [];
//       final newStores = await _loadPage(_currentPage);

//       state = AsyncData([...currentStores, ...newStores]);
//     } catch (e, stack) {
//       _currentPage--; // 실패 시 페이지 번호 복원
//       state = AsyncError(e, stack);
//     } finally {
//       _isLoadingMore = false;
//     }
//   }

//   /// 새로고침 (Pull to Refresh)
//   Future<void> refresh() async {
//     _currentPage = 1;
//     _hasMore = true;
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() => _loadPage(_currentPage));
//   }
// }

// /// 매장 승인 Provider
// @riverpod
// class StoreApproval extends _$StoreApproval {
//   @override
//   FutureOr<void> build() {}

//   Future<void> approve(String storeId) async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(
//       () => ref.read(adminRepositoryProvider).approveStore(storeId),
//     );

//     // 승인 성공 시 리스트 새로고침
//     if (state.hasValue) {
//       ref.invalidate(pendingStoreListNotifierProvider);
//     }
//   }
// }
