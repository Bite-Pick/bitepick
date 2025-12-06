import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/utils/talker_instance.dart';

class MgAsyncAnimatedSwitcher<T> extends ConsumerWidget {
  const MgAsyncAnimatedSwitcher({
    required this.asyncValue,
    required this.builder,
    super.key,
    this.errorBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.alignment,
    this.skipLoadingOnReload = false,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T data) builder;
  final Widget Function(Object? error, StackTrace? stackTrace)? errorBuilder;
  final Widget Function()? loadingBuilder;
  final Widget Function()? emptyBuilder;
  final AlignmentGeometry? alignment;
  final bool skipLoadingOnReload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          alignment: alignment ?? AlignmentDirectional.topStart,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      duration: 200.milliseconds,
      child: asyncValue.when(
        data: (data) {
          if (data is List && data.isEmpty) {
            if (emptyBuilder != null) return emptyBuilder!();

            return Environment.instance.isDev
                ? Center(child: Text('데이터가 없습니다'))
                : SizedBox.shrink();
          }
          return builder(data);
        },
        error: (error, stackTrace) {
          if (errorBuilder != null) {
            talker.error(error);
            return errorBuilder!(error, stackTrace);
          }

          return Center(child: Text('Error: ${error.toString()}'));
        },
        loading: () {
          if (loadingBuilder != null) {
            return loadingBuilder!();
          }

          return const Center(child: CircularProgressIndicator());
        },
        skipLoadingOnReload: skipLoadingOnReload,
      ),
    );
  }
}
