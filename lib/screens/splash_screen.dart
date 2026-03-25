import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen.dart';
import '../utils/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _startAnimation = true;
      });
      Future.delayed(const Duration(milliseconds: 3500), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const OnboardingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF7AAE8E);
    
    final double logoSize = Responsive.value(
      context,
      mobile: 180,
      tablet: 240,
      desktop: 300,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 0.8, end: _startAnimation ? 1.0 : 0.8),
          builder: (context, scale, child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              opacity: _startAnimation ? 1.0 : 0.0,
              child: Transform.scale(
                scale: scale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: 'app_logo',
                      child: ClipOval(
                        child: Image.asset(
                          'public/LOGO-À-ƠI-FINAL.png',
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.value(context, mobile: 24, tablet: 32)),
                    Text(
                      'À Ơi Care',
                      style: GoogleFonts.lobster(
                        fontSize: Responsive.value(context, mobile: 32, tablet: 40, desktop: 48),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: primaryGreen,
                      ),
                    ),
                    SizedBox(height: Responsive.value(context, mobile: 8, tablet: 12)),
                    Text(
                      'Nurture with Peace of Mind.',
                      style: TextStyle(
                        fontSize: Responsive.value(context, mobile: 14, tablet: 16, desktop: 20),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: primaryGreen.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
