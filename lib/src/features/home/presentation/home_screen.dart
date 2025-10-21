import 'package:flutter/material.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/features/home/presentation/widgets/home_goods_item.dart';
import 'package:magambell/src/widgets/base_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          // TODO[home]: 1.주소 설정
          // TODO[home]: 2.검색
          // TODO[home]: 3.필터
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return HomeGoodsItem().margin(all: MgSizes.md);
              },
            ),
          ),
        ],
      ),
    );
  }
}
