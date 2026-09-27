import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/extensions/widget_extension.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_theme.dart';
import 'package:magambell/src/features/review/data/repositories/review_repository.dart';
import 'package:magambell/src/widgets/base_svg_icon.dart';
import 'package:magambell/src/widgets/toast_presentor.dart';
import 'package:flutter/services.dart';

final activeReplyReviewIdProvider = StateProvider.autoDispose<String?>((ref) => null);

class OwnerReplyComposer extends ConsumerStatefulWidget {
  const OwnerReplyComposer({super.key});

  @override
  ConsumerState<OwnerReplyComposer> createState() => _OwnerReplyComposerState();
}

class _OwnerReplyComposerState extends ConsumerState<OwnerReplyComposer> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) _focusNode.requestFocus();
    });
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _controller.text.trim().isEmpty) {
        _cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _cancel() {
    ref.read(activeReplyReviewIdProvider.notifier).state = null;
  }

  Future<void> _submit() async {
    final reviewId = ref.read(activeReplyReviewIdProvider);
    final content = _controller.text.trim();
    if (reviewId == null || content.isEmpty || _isSubmitting) return;

    setState(() => _isSubmitting = true);
    final success = await ref
        .read(reviewRepositoryProvider)
        .addReply(reviewId, content);
    if (!mounted) return;


    setState(() => _isSubmitting = false);
    if (success) {
      ref.invalidate(ownerStoreReviewsProvider);
      ref.read(activeReplyReviewIdProvider.notifier).state = null;
      ToastPresentor.success(context, "답글을 등록했어요.");
    } else {
      ToastPresentor.error(context, "답글 등록에 실패했어요");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MgSizes.md,
        vertical: MgSizes.size10,
      ),
      decoration: const BoxDecoration(
        color: NewColorScheme.gray14,
        border: Border(top: BorderSide(color: NewColorScheme.gray13, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D333333),
            offset: Offset(0, -4),
            blurRadius: 10,
          )
        ],
      ),
      child: SizedBox(
        height: 38,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                cursorColor: NewColorScheme.gray1,
                cursorWidth: MgSizes.size1,
                cursorHeight: MgSizes.md,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: NewColorScheme.gray1,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: '댓글을 입력해주세요.',
                  hintStyle: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    color: NewColorScheme.gray6,
                  ),
                ),
              ),
            ),
            const SizedBox(width: MgSizes.size3),
            GestureDetector(
              onTap: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                    width: MgSizes.size32,
                    height: MgSizes.size32,
                    child: Padding(
                      padding: EdgeInsets.all(MgSizes.size10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: NewColorScheme.gray14,
                      ),
                    ),
                  )
                : BaseSvgIcon.sendButton(size: MgSizes.size32),
            ),
          ],
        ),
      ),
    );
  }
}