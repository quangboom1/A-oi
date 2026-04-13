import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: MediaQuery.of(context).size.width * 0.15,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header with Back Button
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 60, horizontalPadding, 32),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildHeaderIcon(Icons.arrow_back_rounded, context),
                        const SizedBox(width: 20),
                        Text(
                          'Thông tin tài khoản',
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildAvatarHeader(),
                  ],
                ),
              ),
            ),

            // Profile Sections
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildSectionTitle('Thông tin cá nhân'),
                  _buildInfoCard([
                    _buildInfoItem(Icons.person_outline_rounded, 'Họ và tên', 'T.Việt'),
                    _buildInfoItem(Icons.phone_outlined, 'Số điện thoại', '0987 654 321'),
                    _buildInfoItem(Icons.email_outlined, 'Email', 'viet.tn@gmail.com'),
                    _buildInfoItem(Icons.cake_outlined, 'Ngày sinh', '15/04/1995'),
                  ]),
                  
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle('Địa chỉ & Liên hệ'),
                  _buildInfoCard([
                    _buildInfoItem(Icons.location_on_outlined, 'Địa chỉ', 'Lê Duẩn, Đà Nẵng'),
                    _buildInfoItem(Icons.contact_phone_outlined, 'Liên hệ khẩn cấp', '0900 *** 999 (Chồng)'),
                  ]),
                  
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle('Bảo mật'),
                  _buildInfoCard([
                    _buildInfoItem(Icons.lock_outline_rounded, 'Mật khẩu', 'Thay đổi mật khẩu'),
                    _buildInfoItem(Icons.fingerprint_rounded, 'Xác thực sinh trắc học', 'Đã bật'),
                  ]),
                  
                  const SizedBox(height: 40),
                  
                  // Logout
                  _buildLogoutButton(context),
                  
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Icon(icon, size: 20, color: AppTheme.onSurface),
      ),
    );
  }

  Widget _buildAvatarHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=Mason'),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'T.Việt',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Thành viên thân thiết',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.qr_code_2_rounded, color: AppTheme.onSurface, size: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: AppTheme.onSurfaceVariant.withOpacity(0.5),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Column(
            children: List.generate(children.length, (index) {
              return Column(
                children: [
                  children[index],
                  if (index < children.length - 1)
                    Divider(height: 1, color: Colors.white.withOpacity(0.5), indent: 64),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary, size: 22),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.edit_outlined, size: 18, color: AppTheme.onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout_rounded, color: Colors.red, size: 20),
              const SizedBox(width: 12),
              Text(
                'Đăng xuất',
                style: GoogleFonts.inter(
                  color: Colors.red,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



