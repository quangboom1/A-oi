import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/responsive.dart';
import '../../widgets/role_selection_popup.dart';
import 'register_screen.dart';
import '../mother/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 28,
      tablet: Responsive.getWidth(context) * 0.2,
      desktop: Responsive.getWidth(context) * 0.35,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4E7C6), // Fallback color matching splash/theme
      body: Stack(
        children: [
          // --- Layer 1: Background Image ---
          Positioned.fill(
            child: Image.asset(
              'assets/images/auth_bg_v2.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFACCD75), Color(0xFF8AA758)],
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Layer 2: Blur + Dim Overlay ---
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // --- Layer 3: Content ---
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 72),

                  // Logo — centered
                  Center(
                    child: Hero(
                      tag: 'app_logo',
                      child: Image.asset(
                        'assets/images/logo_no_bg.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),


                  const SizedBox(height: 24),

                  // Title
                  Center(
                    child: Text(
                      'Đăng nhập',
                      style: GoogleFonts.inter(
                        fontSize: Responsive.value(context, mobile: 30, tablet: 36),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2E4617),
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Email
                  _buildLabel('Email'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    hint: 'Nhập email của bạn',
                    icon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 20),

                  // Password
                  _buildLabel('Mật khẩu'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    hint: 'Nhập mật khẩu của bạn',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggleVisibility: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),

                  const SizedBox(height: 16),

                  // Remember Me & Forgot
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildBubbleCheckbox(),
                          const SizedBox(width: 8),
                          Text(
                            'Ghi nhớ đăng nhập',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF2E4617).withOpacity(0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Quên mật khẩu?',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF2E4617),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Login Button — bubble style
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    child: const Text('Đăng nhập'),
                  ),

                  const SizedBox(height: 28),

                  // Or Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Hoặc tiếp tục với',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF2E4617).withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Social Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialBubbleButton(
                          icon: Icons.g_mobiledata,
                          label: 'Google',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildSocialBubbleButton(
                          icon: Icons.apple,
                          label: 'Apple',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Sign Up link
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Bạn chưa có tài khoản?",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF2E4617).withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final role = await showRoleSelectionPopup(context);
                            if (role != null && context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(role: role),
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                          ),
                          child: Text(
                            'Đăng ký ngay',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF2E4617),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: const Color(0xFF2E4617),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildBubbleInput({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFACCD75).withOpacity(0.6),
                  const Color(0xFFACCD75).withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E4617).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF2E4617),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    obscureText: isPassword && obscureText,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2E4617),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF2E4617).withOpacity(0.5),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),
                if (isPassword)
                  IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF2E4617).withOpacity(0.7),
                      size: 20,
                    ),
                    splashRadius: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBubbleCheckbox() {
    return GestureDetector(
      onTap: () => setState(() => _rememberMe = !_rememberMe),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _rememberMe
                  ? const Color(0xFF2E4617).withOpacity(0.3)
                  : const Color(0xFF2E4617).withOpacity(0.1),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                color: const Color(0xFF2E4617).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: _rememberMe
                ? Icon(Icons.check, size: 14, color: const Color(0xFF2E4617))
                : null,
          ),
        ),
      ),
    );
  }



  Widget _buildSocialBubbleButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFACCD75).withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFF2E4617), size: 24),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF2E4617),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




