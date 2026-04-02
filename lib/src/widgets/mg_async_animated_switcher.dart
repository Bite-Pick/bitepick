import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/constants/assets.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/config/environment.dart';
import 'package:magambell/src/core/providers/connectivity_provider.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
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
    this.onRetry,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T data) builder;
  final Widget Function(Object? error, StackTrace? stackTrace)? errorBuilder;
  final Widget Function()? loadingBuilder;
  final Widget Function()? emptyBuilder;
  final AlignmentGeometry? alignment;
  final bool skipLoadingOnReload;
  final VoidCallback? onRetry;

  static bool _isNetworkError(Object? error) =>
      error is SocketException ||
      (error is DioException &&
          (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.sendTimeout ||
              error.type == DioExceptionType.receiveTimeout ||
              error.type == DioExceptionType.connectionTimeout));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasNetworkError = asyncValue.hasError && _isNetworkError(asyncValue.error);

    if (onRetry != null && hasNetworkError) {
      ref.listen(connectivityProvider, (previous, next) {
        final prevResults = previous?.asData?.value ?? [ConnectivityResult.none];
        final nextResults = next.asData?.value ?? [ConnectivityResult.none];
        final wasDisconnected = prevResults.every((r) => r == ConnectivityResult.none);
        final isConnected = nextResults.any((r) => r != ConnectivityResult.none);
        if (wasDisconnected && isConnected) {
          onRetry!();
        }
      });
    }

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
                ? Center(child: Text('데이터가 없습니다(DEV에서만 보이는 텍스트)'))
                : SizedBox.shrink();
          }
          return builder(data);
        },
        error: (error, stackTrace) {
          if (errorBuilder != null) {
            talker.error(error);
            return errorBuilder!(error, stackTrace);
          }

          if (_isNetworkError(error)) {
            return Material(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      R.ASSETS_IMAGES_CHARACTER_EMPTY_PNG,
                      height: 165.h,
                    ),
                    Gaps.h12,
                    Text("네트워크 접속 상태를 확인해주세요.").bold(),
                    if (onRetry != null) ...[
                      Gaps.h16,
                      TextButton(
                        onPressed: onRetry,
                        child: const Text("다시 시도"),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }

          return Center(child: Material(child: Text('Error: ${error.toString()}')));
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
