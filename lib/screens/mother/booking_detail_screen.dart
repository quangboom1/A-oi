import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import 'caregiver_detail_screen.dart';

class BookingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingDetailScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.15,
    );

    final Color accentColor = booking['color'] as Color;
    final bool isCompleted = booking['status'] == 'completed';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header with Back Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
                child: Row(
                  children: [
                    _glassIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Chi tiết đặt lịch',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 40),
                  child: Column(
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isCompleted ? Colors.green.withOpacity(0.1) : AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isCompleted ? Icons.check_circle_rounded : Icons.pending_actions_rounded,
                              color: isCompleted ? Colors.green : AppTheme.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isCompleted ? 'Đã hoàn thành' : 'Sắp diễn ra',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isCompleted ? Colors.green : AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Main Detail Card (Border Radius 60)
                      _glassCard(
                        padding: 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['title'],
                              style: GoogleFonts.inter(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.onSurface,
                                letterSpacing: -0.8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              booking['category'],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: accentColor,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            _detailRow(Icons.calendar_today_rounded, 'Ngày & Giờ', booking['date']),
                            const SizedBox(height: 16),
                            _detailRow(Icons.location_on_rounded, 'Địa điểm', booking['location']),
                            const SizedBox(height: 16),
                            _detailRow(Icons.payments_rounded, 'Mã đơn hàng', '#AOI-${booking['caregiverName'].hashCode.abs().toString().substring(0, 5)}'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Caregiver Info Card (Border Radius 60)
                      _glassCard(
                        padding: 24,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(milliseconds: 450),
                                    reverseTransitionDuration: const Duration(milliseconds: 350),
                                    pageBuilder: (_, __, ___) => CaregiverDetailScreen(
                                      name: booking['caregiverName'],
                                      role: booking['caregiverRole'],
                                      initials: booking['initials'] ?? '',
                                      rating: booking['rating'] ?? 0.0,
                                      reviewCount: booking['reviewCount'] ?? 0,
                                      accent: booking['color'],
                                      bio: booking['bio'] ?? '',
                                      specialties: List<String>.from(booking['specialties'] ?? []),
                                      image: booking['caregiverAvatar'],
                                    ),
                                    transitionsBuilder: (_, anim, __, child) {
                                      return FadeTransition(
                                        opacity: CurvedAnimation(
                                          parent: anim,
                                          curve: Curves.easeOutCubic,
                                        ),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'caregiver_avatar_${booking['caregiverName']}',
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(booking['caregiverAvatar']),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kỹ thuật viên',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    booking['caregiverName'],
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    booking['caregiverRole'],
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: AppTheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.primary, size: 22),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Caregiver Notes & Health Tracking (Categorized)
                      if (isCompleted) ...[
                        _glassCard(
                          padding: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.analytics_rounded, color: AppTheme.primary, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Báo cáo & Ghi chú',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // MOTHER SECTION
                              _buildHealthSection(
                                title: 'Sức khỏe của Mẹ',
                                icon: Icons.woman_rounded,
                                iconColor: const Color(0xFFE91E63),
                                metrics: [
                                  {'label': 'Huyết áp', 'value': '110/70', 'status': 'Tốt'},
                                  {'label': 'Hồi phục', 'value': '85%', 'status': 'Ổn định'},
                                ],
                                note: 'Vết mổ đang phục hồi tốt, không có dấu hiệu nhiễm trùng. Mẹ hãy duy trì tư thế ngồi đúng khi cho bé bú và thực hiện bài tập vai gáy.',
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: const Divider(color: Colors.black12),
                              ),

                              // BABY SECTION
                              _buildHealthSection(
                                title: 'Sức khỏe của Bé',
                                icon: Icons.child_care_rounded,
                                iconColor: const Color(0xFF1976D2),
                                metrics: [
                                  {'label': 'Cân nặng', 'value': '3.4 kg', 'status': '+200g'},
                                  {'label': 'Chiều dài', 'value': '52 cm', 'status': '+2cm'},
                                ],
                                note: 'Bé hôm nay ăn ngoan, bú được 8 cử. Phản xạ cầm nắm và xoay đầu về phía âm thanh rất tốt. Giấc ngủ ban ngày đã sâu hơn.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Action Buttons
                      if (!isCompleted)
                        Row(
                          children: [
                            Expanded(
                              child: _actionButton(
                                'Hủy lịch',
                                Colors.red.withOpacity(0.1),
                                Colors.red,
                                () {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _actionButton(
                                'Dời lịch',
                                Colors.white.withOpacity(0.5),
                                AppTheme.onSurface,
                                () {},
                              ),
                            ),
                          ],
                        )
                      else
                        _actionButton(
                          'Đặt lại dịch vụ này',
                          AppTheme.primary,
                          Colors.white,
                          () {},
                          fullWidth: true,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: AppTheme.onSurface.withOpacity(0.6)),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurface.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _glassIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.8)),
        ),
        child: Icon(icon, size: 18, color: AppTheme.onSurface),
      ),
    );
  }

  Widget _glassCard({required Widget child, double padding = 24}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32), // Using 32 for smaller cards inside, but history cards are 60. Let's use 40 for a balanced sub-card.
        // Actually, user said "bo góc 60", so I'll use 60 for consistency.
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _actionButton(String text, Color background, Color textColor, VoidCallback onTap, {bool fullWidth = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            if (background == AppTheme.primary)
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHealthSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Map<String, String>> metrics,
    required String note,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppTheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Metrics Summary Grid
        Row(
          children: metrics.map((m) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildMetricBadge(m['label']!, m['value']!, m['status']!, iconColor),
            ),
          )).toList(),
        ),
        
        const SizedBox(height: 16),
        
        // Detailed Note
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Text(
            note,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.onSurface.withOpacity(0.7),
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricBadge(String label, String value, String status, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.onSurface,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




