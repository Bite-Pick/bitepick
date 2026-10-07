import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magambell/src/core/router/app_router.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/features/onboarding/domain/constants.dart';
import 'package:magambell/src/features/onboarding/presentation/widgets/onboarding_page_indicators.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingData(
      title: '안녕하세요!\n저는 바픽이에요',
      subtitle: "바이트픽은 당일 만든 신선한 빵이 담긴\n'바이트백'을 최대 ",
      subtitleHighlight: '60% 할인된 가격에',
      subtitleSuffix: ' 제공해요.',
      imagePath: 'assets/images/user_onboarding1.png',
      imageWidth: 252,
      imageHeight: 275,
    ),
    _OnboardingData(
      title: '바이트픽으로 결제하고\n편하게 픽업해요',
      subtitle: '원하는 바이트백을 결제하고 사장님이 수락하면,\n픽업시간에 방문하면 돼요!',
      imagePath: 'assets/images/user_onboarding2.png',
    ),
    _OnboardingData(
      title: '어? 매장이 다 닫혀있나요 👀',
      subtitle: '매장의 오픈 알림을 켜두세요.\n매장이 오픈하는 순간, 먼저 알려드릴게요!',
      imagePath: 'assets/images/user_onboarding3.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboardingCompletedKey, true);
    if (!mounted) return;
    MainRoute().go(context);
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
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 148.h),
            SizedBox(
              height: 484.h,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemCount: _pages.length,
                    itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
                  ),
                  Positioned(
                    top: 476.h,
                    left: 168.w,
                    child: OnboardingPageIndicators(
                      count: _pages.length,
                      current: _currentPage,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final _OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 142.h,
          left: 0,
          right: 0,
          height: 322.h,
          child: data.imageWidth != null
              ? Center(
                  child: SizedBox(
                    width: data.imageWidth!.w,
                    height: data.imageHeight!.h,
                    child: Image.asset(data.imagePath, fit: BoxFit.contain),
                  ),
                )
              : Image.asset(data.imagePath, fit: BoxFit.contain),
        ),
        Positioned(
          top: 0,
          left: 53.w,
          width: 270.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(data.title)
                  .bold()
                  .fontSize(24)
                  .height(1.5)
                  .letterSpacing(24 * -0.025)
                  .textMain()
                  .center(),
              SizedBox(height: 12.h),
              _buildSubtitle(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    if (data.subtitleHighlight == null) {
      return Text(data.subtitle)
          .regular()
          .fontSize(15)
          .height(1.5)
          .letterSpacing(15 * -0.025)
          .textGray()
          .center();
    }

    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontFamily: MgFontFamily.regular,
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: MgColorScheme.gray4,
          height: 1.5,
          letterSpacing: 15 * -0.025,
        ),
        children: [
          TextSpan(text: data.subtitle),
          TextSpan(
            text: data.subtitleHighlight,
            style: const TextStyle(
              color: MgColorScheme.primaryHeavy,
              fontFamily: MgFontFamily.semiBold,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (data.subtitleSuffix != null)
            TextSpan(text: data.subtitleSuffix),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.subtitleHighlight,
    this.subtitleSuffix,
    this.imageWidth,
    this.imageHeight,
  });

  final String title;
  final String subtitle;
  final String? subtitleHighlight;
  final String? subtitleSuffix;
  final String imagePath;
  final double? imageWidth;
  final double? imageHeight;
}
