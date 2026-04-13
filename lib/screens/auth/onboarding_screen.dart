import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shader_background.dart';
import 'login_screen.dart';
import '../../utils/responsive.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      imagePath: 'assets/images/splash-1.png',
      title: 'Chào mừng đến với À Ơi',
      subtitle: 'Chăm sóc mẹ và bé một cách toàn diện, an tâm và yêu thương.',
    ),
    _OnboardingData(
      imagePath: 'assets/images/splash-2.png',
      title: 'Đội ngũ chuyên nghiệp',
      subtitle: 'Các điều dưỡng và chuyên gia tư vấn luôn sẵn sàng đồng hành cùng bạn.',
    ),
    _OnboardingData(
      imagePath: 'assets/images/splash-3.png',
      title: 'Bắt đầu hành trình',
      subtitle: 'Đăng nhập để trải nghiệm dịch vụ chăm sóc mẹ và bé tốt nhất.',
    ),
  ];


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 60,
      desktop: Responsive.getWidth(context) * 0.15,
    );

    return Scaffold(
      body: ShaderBackground(
        child: Stack(
          children: [
            // Page View
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return _OnboardingPage(data: _pages[index]);
              },
            ),

            // Top Row: Skip button
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: Responsive.value(context, mobile: 24, tablet: 40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_currentPage < _pages.length - 1)
                        GestureDetector(
                          onTap: _navigateToLogin,
                          child: Text(
                            'Bỏ qua',
                            style: GoogleFonts.inter(
                              color: AppTheme.onSurface,
                              fontWeight: FontWeight.w600,
                              fontSize: Responsive.value(context, mobile: 16, tablet: 18),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Controls: dots + next/login button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    0,
                    horizontalPadding,
                    Responsive.value(context, mobile: 32, tablet: 60),
                  ),
                  child: _currentPage < _pages.length - 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildDots(),
                            _buildNextButton(),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildDots(),
                            SizedBox(height: Responsive.value(context, mobile: 32, tablet: 48)),
                            _buildLoginButton(),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 6),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.black87
                : Colors.black26,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    final double buttonSize = Responsive.value(context, mobile: 56, tablet: 64);
    return GestureDetector(
      onTap: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black87, width: 1.5),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.black87,
          size: Responsive.value(context, mobile: 24, tablet: 28),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    final double maxWidth = Responsive.value(
      context,
      mobile: double.infinity,
      tablet: 400,
    );

    return Container(
      width: maxWidth,
      child: GestureDetector(
        onTap: _navigateToLogin,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.value(context, mobile: 18, tablet: 22),
          ),
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(99),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Đăng nhập',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: Responsive.value(context, mobile: 18, tablet: 20),
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String imagePath;
  final String title;
  final String subtitle;

  const _OnboardingData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isWide = Responsive.isTablet(context) || Responsive.isDesktop(context);
    
    return Column(
      children: [
        // Top image area
        Expanded(
          flex: isWide ? 60 : 60, // Significantly reduced image area to push content UP
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                Responsive.value(context, mobile: 0, tablet: 30),
                0,
                0,
              ),
              child: Align(
                alignment: Alignment.bottomCenter, // Sit at the bottom of the area
                child: Transform.scale(
                  scale: 1.1, // Keep the large size
                  child: Image.asset(
                    data.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Bottom text area
        Expanded(
          flex: isWide ? 40 : 40, // Increased text area
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.value(context, mobile: 32, tablet: 60, desktop: 100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start, // Start closer to the image
              children: [
                const SizedBox(height: 60), // Controlled gap
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: Responsive.value(context, mobile: 26, tablet: 34, desktop: 40),
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: Responsive.value(context, mobile: 14, tablet: 17, desktop: 19),
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }
}




