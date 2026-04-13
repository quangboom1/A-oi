import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shader_background.dart';

// ─────────────────────────────────────────────
//  Review model (local mock)
// ─────────────────────────────────────────────

class _Review {
  final String author;
  final String initials;
  final Color avatarColor;
  final double rating;
  final String date;
  final String text;

  const _Review({
    required this.author,
    required this.initials,
    required this.avatarColor,
    required this.rating,
    required this.date,
    required this.text,
  });
}

// ─────────────────────────────────────────────
//  Screen
// ─────────────────────────────────────────────

class CaregiverDetailScreen extends StatelessWidget {
  /// All fields forwarded from the _Caregiver data in BookingScreen
  final String name;
  final String role;
  final String initials;
  final double rating;
  final int reviewCount;
  final Color accent;
  final String bio;
  final List<String> specialties;
  final String image;

  // Hero tag = unique key per caregiver
  String get heroTag => 'caregiver_avatar_$name';

  const CaregiverDetailScreen({
    super.key,
    required this.name,
    required this.role,
    required this.initials,
    required this.rating,
    required this.reviewCount,
    required this.accent,
    required this.bio,
    required this.specialties,
    required this.image,
  });

  // ── mock reviews
  List<_Review> get _reviews => [
        _Review(
          author: 'Nguyễn Lan Anh',
          initials: 'LA',
          avatarColor: const Color(0xFF90CAF9),
          rating: 5.0,
          date: '15/03/2026',
          text:
              'Chị chăm sóc rất tận tình, bé nhà mình rất thích. Kỹ năng chuyên môn rất tốt, tôi sẽ tiếp tục đặt lịch với chị.',
        ),
        _Review(
          author: 'Trần Thu Hà',
          initials: 'TH',
          avatarColor: const Color(0xFFA5D6A7),
          rating: 5.0,
          date: '10/03/2026',
          text:
              'Rất hài lòng! Chị đến đúng giờ, vệ sinh tắm bé chuẩn y khoa, tư vấn thêm nhiều kiến thức nuôi con hữu ích.',
        ),
        _Review(
          author: 'Phan Minh Châu',
          initials: 'MC',
          avatarColor: const Color(0xFFFFAB91),
          rating: 4.5,
          date: '05/03/2026',
          text:
              'Dịch vụ ổn, chị nhiệt tình. Lần sau sẽ đặt thêm gói massage cho mẹ.',
        ),
        _Review(
          author: 'Lê Bảo Ngọc',
          initials: 'BN',
          avatarColor: const Color(0xFFCE93D8),
          rating: 5.0,
          date: '28/02/2026',
          text:
              'Tuyệt vời! Chị hướng dẫn cách cho bé bú rất dễ hiểu và kiên nhẫn. Bé tăng cân đều sau 2 tuần nhờ sự giúp đỡ của chị.',
        ),
        _Review(
          author: 'Vũ Khánh Linh',
          initials: 'KL',
          avatarColor: const Color(0xFFFFD54F),
          rating: 4.8,
          date: '22/02/2026',
          text:
              'Chị rất chuyên nghiệp và thân thiện. Cảm ơn chị đã hỗ trợ mình trong những ngày đầu sau sinh!',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ─────────────────────────────── Hero header
            SliverToBoxAdapter(child: _buildHeroHeader(context)),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ─────────────────────────────── Stats row
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(child: _buildStatsRow()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ─────────────────────────────── About
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(child: _buildAboutCard()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // ─────────────────────────────── Specialties
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(child: _buildSpecialtiesCard()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ─────────────────────────────── Reviews header
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(
                      'Đánh giá',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$reviewCount',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ─────────────────────────────── Reviews list
            SliverPadding(
              padding:
                  const EdgeInsets.fromLTRB(24, 0, 24, 120),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildReviewCard(_reviews[i]),
                  ),
                  childCount: _reviews.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Hero Header
  // ─────────────────────────────────────────────

  Widget _buildHeroHeader(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.55;

    return SizedBox(
      height: headerHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Full bleed Hero image with Alpha Masking for a literal "merge" with the background
          Hero(
            tag: heroTag,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.65, 1.0], // Fades only the bottom portion
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                  // Noise overlay for "hiệu ứng nhiễu"
                  CustomPaint(
                    painter: _NoisePainter(opacity: 0.15),
                  ),
                ],
              ),
            ),
          ),

          // No static color gradient here! 
          // The background should show through via the ShaderMask above.

          // Name and Role in Bottom-Left
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.onSurface,
                    letterSpacing: -1.0,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  role.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.onSurfaceVariant,
                    letterSpacing: 2.5,
                  ),
                ),
              ],
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 1.5),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Stats Row
  // ─────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _statBox(
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFFF8F00),
            bgColor: const Color(0xFFFFD54F).withOpacity(0.2),
            label: 'Đánh giá',
            value: rating.toStringAsFixed(1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statBox(
            icon: Icons.reviews_rounded,
            iconColor: accent,
            bgColor: accent.withOpacity(0.15),
            label: 'Nhận xét',
            value: '$reviewCount',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statBox(
            icon: Icons.workspace_premium_rounded,
            iconColor: const Color(0xFF5E35B1),
            bgColor: const Color(0xFF5E35B1).withOpacity(0.1),
            label: 'Kinh nghiệm',
            value: '7 năm',
          ),
        ),
      ],
    );
  }

  Widget _statBox({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required String value,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.55),
            borderRadius: BorderRadius.circular(24),
            border:
                Border.all(color: Colors.white.withOpacity(0.7), width: 1.5),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  About Card
  // ─────────────────────────────────────────────

  Widget _buildAboutCard() {
    return _glassCard(
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giới thiệu',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            bio,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Specialties Card
  // ─────────────────────────────────────────────

  Widget _buildSpecialtiesCard() {
    return _glassCard(
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chuyên môn',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: 14),
          ...specialties.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded,
                        size: 14, color: Colors.black87),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    s,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Review Card
  // ─────────────────────────────────────────────

  Widget _buildReviewCard(_Review review) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
                color: Colors.white.withOpacity(0.7), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author row
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: review.avatarColor.withOpacity(0.3),
                      border: Border.all(
                          color: review.avatarColor.withOpacity(0.5),
                          width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        review.initials,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.author,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          review.date,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Star rating
                  Row(
                    children: List.generate(5, (i) {
                      final filled = i < review.rating.floor();
                      final half = !filled &&
                          i < review.rating &&
                          review.rating - i >= 0.5;
                      return Icon(
                        half
                            ? Icons.star_half_rounded
                            : filled
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                        size: 15,
                        color: const Color(0xFFFF8F00),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Text
              Text(
                review.text,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppTheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Shared glass card
  // ─────────────────────────────────────────────

  Widget _glassCard({required Color accent, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(28),
            border:
                Border.all(color: Colors.white.withOpacity(0.7), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -50,
                right: -50,
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(22), child: child),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Noise Painter for "Hiệu ứng nhiễu"
// ─────────────────────────────────────────────

class _NoisePainter extends CustomPainter {
  final double opacity;
  _NoisePainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    // Simulating grain with a very dense points or a shader-like approach
    // For performance and "premium" look, we use a simple procedural noise simulation
    final rect = Offset.zero & size;
    canvas.saveLayer(rect, Paint()..blendMode = BlendMode.overlay);
    
    final paintDots = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 1.0;

    // Draw random "noise" points
    // Note: In a real production app, we'd use a small tiled noise texture asset
    // but here we simulate it for the visual effect.
    for (double i = 0; i < size.width; i += 4) {
      for (double j = 0; j < size.height; j += 4) {
        if ((i + j) % 7 == 0) {
           canvas.drawRect(Rect.fromLTWH(i, j, 1.5, 1.5), paintDots);
        }
      }
    }
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




