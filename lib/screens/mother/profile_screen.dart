import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import '../../widgets/feed_item.dart';

class ProfileScreen extends StatefulWidget {

  final String username;
  final bool isVerified;
  final String? imageUrl;

  const ProfileScreen({
    super.key,
    required this.username,
    this.isVerified = false,
    this.imageUrl,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedFilterIndex = 0;
  bool _isFollowed = true;
  bool _followBounce = false;
  bool _isNotified = false;
  final List<String> _filters = ['Profile', '1 Answer', '2 Questions', '5 posts'];




  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.1,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Full-Width Integrated Profile Card
            SliverToBoxAdapter(
              child: _buildIntegratedProfileCard(context, horizontalPadding),
            ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              // 4. Tabs (About, Photos, Questions)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: _buildTabs(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              // 5. About Info List
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: _buildAboutList(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              // 6. Filter Chips
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding - 8),
                  child: Row(
                    children: List.generate(_filters.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _buildFilterChip(index),
                      );
                    }),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // 7. Post Feed
              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildMiniPost(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    }
    
  Widget _buildRoundIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Icon(icon, color: AppTheme.onSurface, size: 20),
      ),
    );
  }

  Widget _buildIntegratedProfileCard(BuildContext context, double horizontalPadding) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: EdgeInsets.fromLTRB(horizontalPadding, statusBarHeight + 16, horizontalPadding, 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.6)),
            ),
          ),

          child: Column(
            children: [
              // Integrated App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRoundIconButton(Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
                  Text(
                    widget.username,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  _buildRoundIconButton(Icons.more_horiz_rounded),
                ],
              ),
              const SizedBox(height: 32),
              
              // Profile Info
              Row(
                children: [
                  _buildAvatarWithDashedBorder(),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.username,
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.isVerified) ...[
                              const SizedBox(width: 6),
                              Icon(Icons.verified_rounded, size: 20, color: AppTheme.primary),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            _buildStatChip('1M followers'),
                            _buildStatChip('100 following'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: _followBounce ? 1.1 : 1.0),
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeOut,
                      onEnd: () {
                        if (_followBounce) setState(() => _followBounce = false);
                      },
                      builder: (context, scale, child) => Transform.scale(
                        scale: scale,
                        child: child,
                      ),
                      child: _buildLargeActionBtn(
                        _isFollowed ? Icons.check_circle_outline_rounded : Icons.person_add_alt_1_rounded,
                        _isFollowed ? 'Following' : 'Follow',
                        bgColor: _isFollowed ? AppTheme.primary : Colors.white.withOpacity(0.8),
                        iconColor: _isFollowed ? Colors.white : AppTheme.onSurface,
                        textColor: _isFollowed ? Colors.white : AppTheme.onSurface,
                        onTap: () {
                          setState(() {
                            _isFollowed = !_isFollowed;
                            _followBounce = true;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLargeActionBtn(
                      _isNotified ? Icons.notifications_active_rounded : Icons.notifications_none_rounded,
                      'Notify me',
                      bgColor: _isNotified ? AppTheme.background : Colors.white.withOpacity(0.6),
                      borderColor: _isNotified ? AppTheme.c300 : null,
                      iconColor: _isNotified ? AppTheme.c300 : AppTheme.onSurface,
                      onTap: () => setState(() => _isNotified = !_isNotified),
                    ),
                  ),




                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLargeActionBtn(
                      Icons.help_outline_rounded,
                      'Ask',
                      bgColor: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildAvatarWithDashedBorder() {
    return CustomPaint(
      painter: DashedCirclePainter(color: AppTheme.primary.withOpacity(0.4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl ?? 'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(widget.username)}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppTheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildLargeActionBtn(
    IconData icon,
    String label, {
    Color? bgColor,
    Color? borderColor,
    Color? iconColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor ?? Colors.white.withOpacity(0.8), width: 1.5),
        ),

        child: Column(
          children: [
            Icon(icon, color: iconColor ?? AppTheme.onSurface, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textColor ?? AppTheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTabItem(Icons.info_outline_rounded, 'About', true),
        _buildTabItem(Icons.image_outlined, 'Photos', false),
        _buildTabItem(Icons.help_center_outlined, 'Questions', false),
      ],
    );
  }

  Widget _buildTabItem(IconData icon, String label, bool isActive) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: isActive ? AppTheme.onSurface : AppTheme.onSurfaceVariant.withOpacity(0.5)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                color: isActive ? AppTheme.onSurface : AppTheme.onSurfaceVariant.withOpacity(0.5),
              ),
            ),
          ],
        ),
        if (isActive) ...[
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildAboutList() {
    return Column(
      children: [
        _buildAboutItem(Icons.work_outline_rounded, 'Former Email Marketing Specialist at GAOTek 2024- 2025'),
        _buildAboutItem(Icons.school_outlined, 'S.S.C in Commerce, Narinda Govt. High. School Expected 2026'),
        _buildAboutItem(Icons.remove_red_eye_outlined, '655 content views 352 this month'),
        _buildAboutItem(Icons.calendar_month_outlined, 'Joined July 2025'),
      ],
    );
  }

  Widget _buildAboutItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: AppTheme.onSurfaceVariant),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.onSurface,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(int index) {
    final bool isActive = _selectedFilterIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilterIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(isActive ? 0.8 : 0.4)),
        ),
        child: Text(
          _filters[index],
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
            color: isActive ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildMiniPost() {
    return FeedItem(
      username: widget.username,
      time: 'Đăng 2 ngày trước',
      content: 'Trở nên tinh tế, quan sát môi trường xung quanh, học hỏi từ kiến thức, sai lầm và cả những điều giản dị hàng ngày...',
      imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=1000',
      likes: 345,
      comments: 67,
      reposts: 12,
      isVerified: widget.isVerified,
    );
  }

}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 3;
    final double radius = size.width / 2;
    final double circumference = 2 * 3.14159 * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final double actualDashWidth = (circumference / dashCount) - dashSpace;

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (i * (actualDashWidth + dashSpace)) / radius;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        actualDashWidth / radius,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}




