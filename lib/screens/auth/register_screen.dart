import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/role_selection_popup.dart';
import '../mother/home_screen.dart';
import '../caregiver/caregiver_dashboard.dart';
import '../../utils/responsive.dart';

class RegisterScreen extends StatefulWidget {
  final UserRole role;

  const RegisterScreen({super.key, required this.role});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emergencyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _emergencyController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (widget.role == UserRole.mother) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const CaregiverDashboard()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 28,
      tablet: Responsive.getWidth(context) * 0.2,
      desktop: Responsive.getWidth(context) * 0.35,
    );

    return Scaffold(
      body: Stack(
        children: [
          // --- Background ---
          Positioned.fill(
            child: Image.asset(
              'assets/images/auth_bg_v2.png',
              fit: BoxFit.cover,
            ),
          ),

          // --- Glass Overlay ---
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // --- Content ---
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  // Logo
                  Center(
                    child: Hero(
                      tag: 'app_logo',
                      child: Image.asset(
                        'assets/images/logo_no_bg.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),


                  const SizedBox(height: 24),

                  // Title
                  Center(
                    child: Text(
                      'Tạo tài khoản',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2E4617),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Chào mừng ${widget.role == UserRole.mother ? "Mẹ" : "Người chăm sóc"} đến với À Ơi',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xFF2E4617).withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Name
                  _buildLabel('Họ và tên'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    controller: _nameController,
                    hint: 'Nhập họ và tên của bạn',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 20),

                  // Email
                  _buildLabel('Email'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    controller: _emailController,
                    hint: 'Nhập địa chỉ email',
                    icon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 20),

                  // Phone Number
                  _buildLabel('Số điện thoại'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    controller: _phoneController,
                    hint: 'Nhập số điện thoại của bạn',
                    icon: Icons.phone_outlined,
                  ),

                  const SizedBox(height: 20),

                  // Birthday
                  _buildLabel('Ngày sinh'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    controller: _dobController,
                    hint: 'Ngày / Tháng / Năm',
                    icon: Icons.cake_outlined,
                  ),

                  const SizedBox(height: 20),

                  // Address
                  _buildLabel('Địa chỉ'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    controller: _addressController,
                    hint: 'Nhập địa chỉ của bạn',
                    icon: Icons.location_on_outlined,
                  ),

                  const SizedBox(height: 20),

                  // Emergency
                  _buildLabel('Liên hệ khẩn cấp'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    controller: _emergencyController,
                    hint: 'Số điện thoại người thân',
                    icon: Icons.contact_phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 20),

                  // Password
                  _buildLabel('Mật khẩu'),
                  const SizedBox(height: 10),
                  _buildBubbleInput(
                    controller: _passwordController,
                    hint: 'Tạo mật khẩu bảo mật',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggleVisibility: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),

                  const SizedBox(height: 40),

                  // Register Button
                  ElevatedButton(
                    onPressed: _handleRegister,
                    child: const Text('Tiếp tục'),
                  ),

                  const SizedBox(height: 24),

                  // Back to Login
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Đã có tài khoản? Đăng nhập',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2E4617),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers ---

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
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFACCD75).withOpacity(0.6  ),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF2E4617), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: isPassword && obscureText,
                    keyboardType: keyboardType,
                    style: GoogleFonts.inter(color: const Color(0xFF2E4617), fontSize: 15),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF2E4617).withOpacity(0.5),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                  ),
                ),
                if (isPassword)
                  IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xFF2E4617).withOpacity(0.7),
                      size: 20,
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




