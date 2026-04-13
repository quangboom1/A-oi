import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import 'booking_screen.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.15,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.4)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppTheme.onSurface),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Dịch vụ',
                      style: GoogleFonts.inter(
                        fontSize: Responsive.value(context, mobile: 28, tablet: 32),
                        fontWeight: FontWeight.w800,
                        color: AppTheme.onSurface,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Chọn gói chăm sóc phù hợp nhất cho mẹ và bé',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: AppTheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Package List
            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 120),


              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // 30 Days (VIP)
                  _buildPackageCard(
                    context: context,
                    title: 'Gói 30 Ngày',
                    subtitle: 'Chăm sóc toàn diện, trọn vẹn yêu thương',
                    price: 'Từ 9.900.000đ',
                    accentColor: const Color(0xFFFFD54F), // Gold/Yellow
                    badgeText: 'Tiết kiệm 20% & Best Value',
                    emoji: '👑',
                    features: [
                      'Chăm sóc mẹ & bé toàn diện 30 ngày',
                      'Massage phục hồi vóc dáng chuyên sâu',
                      'Hỗ trợ thông tắc tia sữa 24/7',
                      'Tư vấn dinh dưỡng độc quyền',
                    ],
                    isFeatured: true,
                  ),
                  const SizedBox(height: 24),

                  // 15 Days
                  _buildPackageCard(
                    context: context,
                    title: 'Gói 15 Ngày',
                    subtitle: 'Phục hồi cơ bản sau sinh',
                    price: 'Từ 6.600.000đ',
                    accentColor: const Color(0xFFFFAB91), // Peach
                    badgeText: 'Phổ biến nhất',
                    emoji: '🌸',
                    features: [
                      'Tắm bé & Vệ sinh chuẩn Y khoa',
                      'Chăm sóc mẹ cơ bản (Vết mổ/khâu)',
                      'Massage bụng giảm eo',
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Single
                  _buildPackageCard(
                    context: context,
                    title: 'Gói Lẻ (Trải nghiệm)',
                    subtitle: 'Linh hoạt theo nhu cầu hàng ngày',
                    price: 'Chỉ 500.000đ / buổi',
                    accentColor: const Color(0xFF90CAF9), // Ice Blue
                    emoji: '💧',
                    features: [
                      'Linh hoạt đặt lịch từng buổi',
                      'Trải nghiệm Tắm bé hoặc Massage mẹ',
                      'Không ràng buộc hợp đồng',
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Full-month celebration
                  _buildPackageCard(
                    context: context,
                    title: 'Mâm Cúng Đầy Tháng',
                    subtitle: 'Đánh dấu cột mốc đầu đời của bé',
                    price: 'Từ 20.000.000đ',
                    accentColor: const Color(0xFFF48FB1), // Pink/Coral
                    badgeText: 'Trọn gói lễ vật',
                    emoji: '🎁',
                    features: [
                      'Trọn gói lễ vật cúng mụ truyền thống',
                      'Xôi chè, hoa quả, giấy tiền chuẩn phong tục',
                      'Hỗ trợ sắp xếp & bài cúng chi tiết',
                    ],
                  ),
                ]),
              ),
            ),
            ],

          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String price,
    required Color accentColor,
    required String emoji,
    required List<String> features,
    String? badgeText,
    bool isFeatured = false,
  }) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),

        boxShadow: [
          BoxShadow(
            color: isFeatured ? accentColor.withOpacity(0.12) : Colors.black12,
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.white.withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(60),

              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Stack(
              children: [
                // Accent Blob highlight
                Positioned(
                  top: -80,
                  right: -80,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                // Main Content
                Padding(
                  padding: EdgeInsets.all(isMobile ? 24 : 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Content Left
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Badge (Optional)
                                if (badgeText != null) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: accentColor.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                                    ),
                                    child: Text(
                                      badgeText,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.brown.shade900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],

                                // Title & Subtitle
                                Text(
                                  title,
                                  style: GoogleFonts.inter(
                                    fontSize: isMobile ? 24 : 30,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  subtitle,
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Features List
                                ...features.map((feature) => Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 2),
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: accentColor.withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.check_rounded, size: 14, color: Colors.black87),
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Text(
                                              feature,
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),

                          // Right side Emoji
                          if (!Responsive.isMobile(context) || MediaQuery.of(context).size.width > 350)
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: isMobile ? 80 : 120,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                ),
                                child: Center(
                                  child: Text(
                                    emoji,
                                    style: TextStyle(
                                      fontSize: isMobile ? 40 : 56,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giá trọn gói',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            price,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Buttons Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildGlassAction(
                              text: 'Xem chi tiết',
                              color: const Color(0xFFF4E7C6),
                              textColor: Colors.brown.shade900,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BookingScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildGlassAction(
                              text: 'Chọn gói',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BookingScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassAction({
    required String text,
    required VoidCallback onTap,
    Color? color,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: color ?? AppTheme.primary,
          borderRadius: BorderRadius.circular(60),
          border: color != null ? Border.all(color: Colors.brown.withOpacity(0.15), width: 1.2) : null,
          boxShadow: [
            BoxShadow(
              color: (color ?? AppTheme.primary).withOpacity(0.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: textColor ?? Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}






