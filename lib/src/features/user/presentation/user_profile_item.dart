import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/features/auth/domain/entities/auth_provider_type.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem({super.key, this.size = 30, this.providerType});
  final int size;
  final AuthProviderType? providerType;

  String get _assetPath {
    switch (providerType) {
      case AuthProviderType.KAKAO:
        return R.ASSETS_IMAGES_KAKAO_LOGIN_PNG;
      case AuthProviderType.NAVER:
        return R.ASSETS_IMAGES_NAVER_LOGIN_PNG;
      case AuthProviderType.APPLE:
        return R.ASSETS_IMAGES_APPLE_LOGIN_PNG;
      case null:
        return R.ASSETS_LOGO_LOGO_PNG;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        _assetPath,
        width: size.w,
        height: size.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
