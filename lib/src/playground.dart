// Container(
//         width: double.infinity,
//         height: 200,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: canAddMore ? MgColorScheme.gray3 : MgColorScheme.gray7,
//             width: 1.5,
//           ),
//           borderRadius: BorderRadius.circular(MgRadius.md),
//           color: MgColorScheme.gray1.withOpacity(0.3),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.camera_alt_outlined,
//               size: 48,
//               color: canAddMore ? MgColorScheme.gray5 : MgColorScheme.gray7,
//             ),
//             Gaps.h12,
//             Text('사진추가 (${localImages.length}/5)').md().textColor(
//               canAddMore ? MgColorScheme.gray5 : MgColorScheme.gray7,
//             ),
//             if (!canAddMore) ...[
//               Gaps.h8,
//               Text(
//                 '최대 5장까지 추가 가능합니다',
//               ).sm().textColor(MgColorScheme.subpointRed),
//             ],
//           ],
//         ),
//       ),