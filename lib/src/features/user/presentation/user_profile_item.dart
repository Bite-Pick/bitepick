import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem({super.key, this.size = 40});
  final int size;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        R.ASSETS_LOGO_LOGO_PNG,
        width: size.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
