// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:magambell/src/constants/index.dart';
// import 'package:magambell/src/core/extensions/widget_extension.dart';
// import 'package:magambell/src/core/theme/mg_color.dart';
// import 'package:magambell/src/features/auth/presenation/owner/widgets/owner_info_section.dart';
// import 'package:magambell/src/features/auth/presenation/owner/widgets/store_info_section.dart';
// import 'package:magambell/src/widgets/base_appbar.dart';
// import 'package:magambell/src/widgets/base_scaffold.dart';
// import 'package:magambell/src/widgets/mg_button.dart';
// import 'package:magambell/src/widgets/toast_presentor.dart';
// import 'package:reactive_forms/reactive_forms.dart';


// NOTE: 추후 가입 매장 전체목록 나오면 해당 화면 활성화
// class StoreInfoEditScreen extends ConsumerStatefulWidget {
//   const StoreInfoEditScreen({super.key});

//   @override
//   ConsumerState<StoreInfoEditScreen> createState() =>
//       _StoreInfoEditScreenState();
// }

// class _StoreInfoEditScreenState extends ConsumerState<StoreInfoEditScreen> {
//   late FormGroup form;
//   List<String> localImages = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeForm();
//     _loadStoreData();
//   }

//   void _initializeForm() {
//     form = FormGroup({
//       'storeName': FormControl<String>(
//         value: '',
//         validators: [Validators.required],
//       ),
//       'postalCode': FormControl<String>(
//         value: '',
//         validators: [Validators.required],
//       ),
//       'address': FormControl<String>(
//         value: '',
//         validators: [Validators.required],
//       ),
//       'addressDetail': FormControl<String>(
//         value: '',
//       ),
//       'latitude': FormControl<double?>(
//         value: null,
//       ),
//       'longitude': FormControl<double?>(
//         value: null,
//       ),
//       'parkingDescription': FormControl<String>(
//         value: '',
//       ),
//       'representativeName': FormControl<String>(
//         value: '',
//         validators: [Validators.required],
//       ),
//       'representativePhone': FormControl<String>(
//         value: '',
//         validators: [Validators.required],
//       ),
//       'businessNumber': FormControl<String>(
//         value: '',
//         validators: [Validators.required, Validators.minLength(10)],
//       ),
//       'bankName': FormControl<String?>(
//         value: null,
//         validators: [Validators.required],
//       ),
//       'accountNumber': FormControl<String>(
//         value: '',
//         validators: [Validators.required],
//       ),
//     });
//   }

//   void _loadStoreData() {
//     // TODO: 서버에서 매장 데이터 로드
//     // 예시 데이터로 폼 채우기
//     form.patchValue({
//       'storeName': '이디야 계양점',
//       'postalCode': '12345',
//       'address': '소금빵과 마늘렐맛집이에요!',
//       'addressDetail': '경기 용인시 수지구 죽전로 143 1층',
//       'latitude': 37.5058,
//       'longitude': 127.0516,
//       'parkingDescription': '가게 앞에 주차하시면됩니다~',
//       'representativeName': '김민경',
//       'representativePhone': '01095770671',
//       'businessNumber': '1234567890',
//       'bankName': '004',
//       'accountNumber': '1234561234567',
//     });

//     // 이미지 데이터 로드
//     setState(() {
//       localImages = [
//         // TODO: 실제 이미지 URL로 대체
//       ];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ReactiveForm(
//       formGroup: form,
//       child: BaseScaffold(
//         appBar: const BaseAppBar(
//           title: Text("입점 매장정보 수정"),
//         ),
//         backgroundColor: MgColorScheme.white,
//         body: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     StoreInfoSection(
//                       localImages: localImages,
//                       onAddImages: (images) {
//                         setState(() {
//                           localImages.addAll(images);
//                         });
//                       },
//                       onRemoveImage: (index) {
//                         setState(() {
//                           localImages.removeAt(index);
//                         });
//                       },
//                       onUpdateAddress: ({
//                         required String postalCode,
//                         required String address,
//                         double? latitude,
//                         double? longitude,
//                       }) {
//                         form.patchValue({
//                           'postalCode': postalCode,
//                           'address': address,
//                           'latitude': latitude,
//                           'longitude': longitude,
//                         });
//                       },
//                       enabled: true, // 수정 가능
//                     ).margin(horizontal: MgSizes.xl),
//                     Divider(thickness: MgSizes.size6).margin(top: MgSizes.xxxl),
//                     const OwnerInfoSection(
//                       enabled: true, // 수정 가능
//                     ).margin(horizontal: MgSizes.xl),
//                   ],
//                 ),
//               ),
//             ),
//             // 수정 완료 버튼
//             MgButton(
//               onPressed: form.invalid ? null : _handleSave,
//               content: const Text('수정 완료'),
//               disabled: form.invalid,
//             ).primary().margin(
//               horizontal: MgSizes.md,
//               bottom: MgSizes.xxl,
//               top: MgSizes.md,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleSave() async {
//     if (form.invalid) return;

//     // TODO: 서버에 수정된 데이터 저장
//     debugPrint('매장 정보 수정: ${form.value}');

//     if (mounted) {
//       ToastPresentor.success(context, "매장 정보가 수정되었습니다");
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   void dispose() {
//     form.dispose();
//     super.dispose();
//   }
// }
