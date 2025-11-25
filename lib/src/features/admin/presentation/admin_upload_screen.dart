import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/extensions/list_extension.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/admin/presentation/banner_register_screen.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';

class AdminUploadScreen extends ConsumerWidget {
  const AdminUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          title: Text('배너 업로드'),
          trailing: BaseSvgIcon.right(),
          onTap: () {
            BannerRegisterRoute().push(context);
          },
        ),
      ].joinWithWidget(Divider()),
    );
  }
}
