import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magambell/src/constants/index.dart';
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
  bool _isEdit = false;
  String get _label => _isEdit ? '수정' : '등록';

  @override
  void initState() {
    super.initState();
    final reviewId = ref.read(activeReplyReviewIdProvider);
    final review = ref
        .read(ownerStoreReviewsProvider())
        .value
        ?.items
        .where((e) => e.reviewId == reviewId)
        .firstOrNull;
    final existing = review?.reply?.content;
    if (existing != null) {
      _isEdit = true;
      _controller.value = TextEditingValue(
        text: existing,
        selection: TextSelection.collapsed(offset: existing.length),
      );
    }
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
    final container = ProviderScope.containerOf(context, listen: false);
    try {
      final repo = ref.read(reviewRepositoryProvider);
      final success = _isEdit
          ? await repo.updateReply(reviewId, content)
          : await repo.addReply(reviewId, content);
      if (success) container.invalidate(ownerStoreReviewsProvider);
      if (!mounted) return;

      setState(() => _isSubmitting = false);
      if (success) {
        ref.read(activeReplyReviewIdProvider.notifier).state = null;
        ToastPresentor.success(context, "답글을 $_label했어요.");
      } else {
        ToastPresentor.error(context, "답글 $_label에 실패했어요");
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ToastPresentor.error(context, "답글 $_label에 실패했어요");
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