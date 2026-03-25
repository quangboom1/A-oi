import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/shader_background.dart';

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

    return ShaderBackground(
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
                    price: 'Từ 15.000.000đ',
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
                    price: 'Từ 8.500.000đ',
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
                    price: 'Chỉ 350.000đ / buổi',
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
                    price: 'Từ 2.900.000đ',
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: isFeatured ? Border.all(color: accentColor.withOpacity(0.5), width: 2) : Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: isFeatured ? accentColor.withOpacity(0.15) : Colors.black.withOpacity(0.04),
              blurRadius: isFeatured ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 1. Background Blur Blob
            Positioned(
              top: -60,
              right: -60,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // 2. Main Content
            Padding(
              padding: EdgeInsets.all(isMobile ? 24 : 32),
              child: Row(
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
                              color: isFeatured ? accentColor.withOpacity(0.2) : AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              badgeText,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isFeatured ? const Color(0xFFD4AF37) : AppTheme.primary, // Adjust gold for text if needed
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
                            fontWeight: FontWeight.w800,
                            color: AppTheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppTheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Features List
                        ...features.map((feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
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
                                    child: Icon(Icons.check_rounded, size: 14, color: isFeatured ? const Color(0xFFD4AF37) : accentColor),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: AppTheme.onSurface.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),

                        const SizedBox(height: 24),

                        // Price & Button
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              price,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: isFeatured ? const Color(0xFFD4AF37) : AppTheme.primary,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isFeatured ? AppTheme.primary : AppTheme.onSurface,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ),
                              child: Text(
                                'Xem chi tiết',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 3D/Emoji Right (Hidden on very small screens, or scaled)
                  if (!Responsive.isMobile(context) || MediaQuery.of(context).size.width > 350)
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: isMobile ? 80 : 120,
                            height: isMobile ? 80 : 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                emoji,
                                style: TextStyle(
                                  fontSize: isMobile ? 40 : 60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
