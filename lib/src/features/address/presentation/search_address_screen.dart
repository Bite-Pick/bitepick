// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:magambell/src/constants/index.dart';
// import 'package:magambell/src/core/extensions/list_extension.dart';
// import 'package:magambell/src/core/extensions/widget_extension.dart';
// import 'package:magambell/src/core/theme/mg_color.dart';
// import 'package:magambell/src/core/theme/mg_text_style.dart';
// import 'package:magambell/src/features/address/domain/entities/address.dart';
// import 'package:magambell/src/features/address/domain/entities/area.dart';
// import 'package:magambell/src/features/address/presentation/search_address_screen.controller.dart';
// import 'package:magambell/src/features/address/presentation/widget/search_address_result_item.dart';
// import 'package:magambell/src/widgets/base_appbar.dart';
// import 'package:magambell/src/widgets/base_scaffold.dart';
// import 'package:magambell/src/widgets/base_svg_icon.dart';
// import 'package:magambell/src/widgets/mg_button.dart';
// import 'package:magambell/src/widgets/mg_textfield.dart';
// import 'package:magambell/src/widgets/toast_presentor.dart';

// class SearchAddressRoute extends GoRouteData {
//   const SearchAddressRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const SearchAddressScreen();
//   }
// }

// class SearchAddressScreen extends ConsumerStatefulWidget {
//   const SearchAddressScreen({super.key});

//   @override
//   ConsumerState<SearchAddressScreen> createState() =>
//       _SearchAddressScreenState();
// }

// class _SearchAddressScreenState extends ConsumerState<SearchAddressScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _isEditMode = false;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controllerState = ref.watch(searchAddressScreenControllerProvider);
//     final controller = ref.read(searchAddressScreenControllerProvider.notifier);

//     // 메시지 리스너
//     ref.listen(searchAddressScreenControllerProvider.select((s) => s.message), (
//       previous,
//       next,
//     ) {
//       if (next != null) {
//         ToastPresentor.success(context, next);
//         controller.clearMessage();
//       }
//     });

//     return BaseScaffold(
//       appBar: BaseAppBar(
//         title: const Text("주소 설정"),
//         action: MgButton(
//           onPressed: () => setState(() => _isEditMode = !_isEditMode),
//           content: Text(_isEditMode ? "완료" : "편집").textGray().regular(),
//         ),
//       ),
//       body: Column(
//         children: [
//           MgTextField(
//             controller: _searchController,
//             hintText: '지역의 동 이름으로 검색해보세요!',
//             onChanged: (text) => controller.setSearchText(text),
//             onSubmitted: (text) => controller.searchNow(),
//           ),
//           MgButton(
//             onPressed: controllerState.isLoading
//                 ? null
//                 : controller.getCurrentLocation,
//             content: Text("현재 위치로 찾기").xs().regular(),
//             padding: Gutter.hsm,
//           ).gray(),
//           Gaps.h16,
//           Expanded(
//             child: controllerState.areaSearchResults.isNotEmpty
//                 ? _buildSearchResultsList(controllerState.areaSearchResults)
//                 : _buildSavedAddressesList(controllerState.addresses),
//           ),
//         ],
//       ).margin(horizontal: MgSizes.md),
//     );
//   }

//   /// 검색 결과 리스트
//   Widget _buildSearchResultsList(List<Area> results) {
//     final controller = ref.read(searchAddressScreenControllerProvider.notifier);

//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final area = results[index];
//         return GestureDetector(
//           onTap: () {
//             controller.selectAreaAsAddress(area);
//             _searchController.clear();
//           },
//           child:
//               Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [Text(area.displayName).md().bold()],
//                   )
//                   .margin(all: MgSizes.md)
//                   .decorated(
//                     border: Border(
//                       bottom: BorderSide(color: MgColorScheme.gray9, width: 1),
//                     ),
//                   ),
//         );
//       },
//     );
//   }

//   /// 저장된 주소 리스트
//   Widget _buildSavedAddressesList(List<Address> addresses) {
//     // TODO: 빈 UI 추가

//     if (addresses.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BaseSvgIcon.mapPin(size: 48).gray(),
//             Gaps.h16,
//             Text("저장된 주소가 없습니다").md().textGray(),
//             Gaps.h8,
//             Text("검색 또는 현재 위치로 주소를 추가해보세요").xs().textGray(),
//           ],
//         ),
//       );
//     }

//     return Column(
//       children: addresses
//           .map(
//             (address) =>
//                 SearchAddressResultItem(address, isEditMode: _isEditMode),
//           )
//           .joinWithWidget(Divider()),
//     );
//   }
// }
