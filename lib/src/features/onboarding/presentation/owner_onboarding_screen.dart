import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/features/owner/prsentation/owner_home_screen.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/onboarding/domain/constants.dart';
import 'package:magambell/src/features/onboarding/presentation/widgets/onboarding_page_indicators.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerOnboardingScreen extends StatefulWidget {
  const OwnerOnboardingScreen({super.key});

  @override
  State<OwnerOnboardingScreen> createState() => _OwnerOnboardingScreenState();
}

class _OwnerOnboardingScreenState extends State<OwnerOnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OwnerOnboardingData(
      badge: '바이트픽에서',
      title: '남은 빵으로 추가 매출을\n만들어보세요!',
      imagePath: 'assets/images/owner_onboarding1.png',
    ),
    _OwnerOnboardingData(
      badge: '바이트백이란?',
      title: '당일 남은 빵을 세트로\n묶어 파는 박스예요',
      subtitle: '매일 메뉴를 올릴 필요 없어요.\n남은 빵 금액에 맞춰 담아드리면 끝이에요.',
      imagePath: 'assets/images/owner_onboarding2.png',
      titleWidth: 202,
    ),
    _OwnerOnboardingData(
      badge: '판매 방법',
      title: '버튼 세번이면\n오늘 판매 준비 끝!',
      subtitle: '영업중 켜고, 개수만 입력하면 준비 끝\n주문 오면 수락만 해요.',
      imagePath: 'assets/images/owner_onboarding3.png',
      titleWidth: 164,
    ),
    _OwnerOnboardingData(
      badge: '예약 취소',
      title: '재고 걱정 없이\n편하게 시작하세요',
      subtitle: '예약 먼저 받고, 재고가 없으면 취소하면 돼요.\n부담 갖지 마세요!',
      imagePath: 'assets/images/owner_onboarding4.png',
      titleWidth: 167,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOwnerOnboardingCompletedKey, true);
    if (!mounted) return;
    OwnerHomeRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: NewColorScheme.gray14,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _buildPage(i),
              ),
            ),
            OnboardingPageIndicators(
              count: _pages.length,
              current: _currentPage,
            ),
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: MgButton(
                onPressed: _currentPage < _pages.length - 1
                    ? () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                    : _completeOnboarding,
                fullWidth: true,
                height: 52.h,
                content: Text(_currentPage < _pages.length - 1 ? '다음' : '시작하기'),
              ).primary(),
            ),
            SizedBox(height: 34.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    final page = _pages[index];
    if (index == 0) return _buildFirstPage(page);
    return _buildTextPage(page);
  }

  Widget _buildFirstPage(_OwnerOnboardingData page) {
    return Column(
      children: [
        SizedBox(height: 108.h),
        _BadgeChip(label: page.badge),
        SizedBox(height: 12.h),
        SizedBox(
          width: 270.w,
          child: Text(page.title)
              .bold()
              .fontSize(24)
              .height(1.4)
              .letterSpacing(24 * -0.025)
              .textMain()
              .center(),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 380.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                page.imagePath!,
                width: 220.w,
                height: 192.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10.h),
              const _CostTooltip(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextPage(_OwnerOnboardingData page) {
    return Column(
      children: [
        SizedBox(height: 108.h),
        _BadgeChip(label: page.badge),
        SizedBox(height: 12.h),
        SizedBox(
          width: page.titleWidth!.w,
          child: Text(page.title)
              .bold()
              .fontSize(24)
              .height(1.5)
              .letterSpacing(24 * -0.025)
              .textColor(NewColorScheme.gray1)
              .center(),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: 270.w,
          child: Text(page.subtitle!)
              .regular()
              .fontSize(15)
              .height(1.5)
              .letterSpacing(15 * -0.025)
              .textColor(NewColorScheme.gray5)
              .center(),
        ),
        SizedBox(height: 12.h),
        if (page.imagePath != null)
          Image.asset(
            page.imagePath!,
            width: 375.w,
            height: 360.h,
            fit: BoxFit.contain,
          ),
      ],
    );
  }
}

class _CostTooltip extends StatelessWidget {
  const _CostTooltip();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 155.w,
            height: 6.h,
            child: CustomPaint(painter: _ArrowPainter()),
          ),
          Container(
            height: 41.h,
            decoration: BoxDecoration(
              color: NewColorScheme.gray2,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: MgFontFamily.semiBold,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.5,
                  letterSpacing: 14 * -0.025,
                ),
                children: const [
                  TextSpan(
                      text: '입점비 ', style: TextStyle(color: NewColorScheme.gray14)),
                  TextSpan(
                      text: '0원',
                      style: TextStyle(color: MgColorScheme.primaryHeavy)),
                  TextSpan(
                      text: ' · 수수료 ',
                      style: TextStyle(color: NewColorScheme.gray14)),
                  TextSpan(
                      text: '0원!',
                      style: TextStyle(color: MgColorScheme.primaryHeavy)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = NewColorScheme.gray2;
    final tipX = size.width / 2;
    final path = Path()
      ..moveTo(tipX, 0)
      ..lineTo(tipX + 10, size.height)
      ..lineTo(tipX - 10, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: NewColorScheme.gray2,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(label)
          .bold()
          .fontSize(13)
          .height(1.5)
          .letterSpacing(13 * -0.025)
          .textColor(NewColorScheme.gray14)
          .center(),
    );
  }
}

class _OwnerOnboardingData {
  const _OwnerOnboardingData({
    required this.badge,
    required this.title,
    this.subtitle,
    this.imagePath,
    this.titleWidth,
  });

  final String badge;
  final String title;
  final String? subtitle;
  final String? imagePath;
  final double? titleWidth;
}
