import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_mother_baby_screen.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import '../../widgets/main_header.dart';

class MotherBabyScreen extends StatefulWidget {
  const MotherBabyScreen({super.key});

  @override
  State<MotherBabyScreen> createState() => _MotherBabyScreenState();
}

class _MotherBabyScreenState extends State<MotherBabyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0; // 0 = Mẹ, 1 = Bé

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedTab = _tabController.index);
    });
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
      mobile: 20,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.1,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Main Header ──────────────────────────────────────
              SliverToBoxAdapter(
                child: MainHeader(horizontalPadding: horizontalPadding),
              ),

              // ── Page Title & Actions ─────────────────────────────
              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'QUẢN LÝ HỒ SƠ',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Mẹ & Bé',
                              style: GoogleFonts.inter(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.onSurface,
                                height: 0.95,
                                letterSpacing: -1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildHeaderAction(
                        Icons.edit_note_rounded,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditMotherBabyScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── Animated Tab Switcher ──────────────────────────
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: _buildPremiumTabSwitcher(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── Dynamic Profile Content ───────────────────────
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Hero Profile Card
                      _selectedTab == 0
                          ? _buildMotherHero()
                          : _buildBabyHero(),
                      
                      const SizedBox(height: 32),
                      
                      // Stats Grid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chỉ số sinh hiệu',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          Text(
                            'Xem biểu đồ',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _selectedTab == 0
                          ? _buildMotherStatsGrid()
                          : _buildBabyStatsGrid(),
                      
                      const SizedBox(height: 40),
                      
                      // Detailed Info Section
                      _buildSectionHeader(
                        _selectedTab == 0 ? 'Tình trạng sức khỏe' : 'Cột mốc phát triển',
                        _selectedTab == 0 ? 'Cập nhật 2 giờ trước' : 'Đang theo dõi',
                      ),
                      const SizedBox(height: 16),
                      _selectedTab == 0
                          ? _buildMotherHealthList()
                          : _buildBabyMilestoneList(),

                      const SizedBox(height: 40),
                      
                      // Daily Activity Log
                      _buildSectionHeader(
                        _selectedTab == 0 ? 'Nhật ký cá nhân' : 'Lịch trình sinh hoạt',
                        'Hôm nay, 04/04',
                      ),
                      const SizedBox(height: 16),
                      _selectedTab == 0
                          ? _buildMotherDailyLog()
                          : _buildBabyDailyLog(),
                      
                      const SizedBox(height: 120),
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

  // ─── Premium Components ──────────────────────────────────────────────────

  Widget _buildHeaderAction(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppTheme.onSurface),
      ),
    );
  }

  Widget _buildPremiumTabSwitcher() {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.c100.withOpacity(0.5),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sliding background indicator
          AnimatedAlign(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            alignment: _selectedTab == 0 ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Tab Buttons
          Row(
            children: [
              _buildModernTab(0, 'Người Mẹ', 'assets/icons/care.svg'),
              _buildModernTab(1, 'Em Bé', 'assets/icons/baby.svg'),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernTab(int index, String label, String iconPath) {
    final bool isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
          setState(() => _selectedTab = index);
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                isActive ? AppTheme.primary : AppTheme.onSurfaceVariant.withOpacity(0.5),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                color: isActive ? AppTheme.onSurface : AppTheme.onSurfaceVariant.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppTheme.onSurfaceVariant.withOpacity(0.3)),
      ],
    );
  }

  Widget _buildPremiumCard({required Widget child, Color? bgColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  // ─── MOTHER SPECIFIC ──────────────────────────────────────────────────────

  Widget _buildMotherHero() {
    return _buildPremiumCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 84,
                height: 84,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.primary.withOpacity(0.3), width: 1.5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent('MomAoI')}'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Thị Lan',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: AppTheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          'Mẹ sau sinh · 12 ngày',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.auto_awesome, size: 10, color: AppTheme.primary),
                          const SizedBox(width: 4),
                          Text(
                            'Sức khỏe ổn định',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.primary,
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
          const SizedBox(height: 28),
          Row(
            children: [
              _buildMiniBox(Icons.cake_outlined, '28 t', const Color(0xFFFCE7F3), const Color(0xFFDB2777)),
              const SizedBox(width: 12),
              _buildMiniBox(Icons.monitor_weight_outlined, '54 kg', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
              const SizedBox(width: 12),
              _buildMiniBox(Icons.straighten_rounded, '162 cm', const Color(0xFFF0FDF4), const Color(0xFF16A34A)),
              const SizedBox(width: 12),
              _buildMiniBox(Icons.bloodtype_outlined, 'A+', const Color(0xFFFEF2F2), const Color(0xFFDC2626)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniBox(IconData icon, String value, Color bgColor, Color iconColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: bgColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: iconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotherStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2,
      children: [
        _buildVisualStatCard('Huyết áp', '110/70', 'mmHg', Icons.favorite_rounded, const Color(0xFFFDF2F2), const Color(0xFFEF4444)),
        _buildVisualStatCard('Nhịp tim', '74', 'bpm', Icons.monitor_heart_outlined, const Color(0xFFF5F3FF), const Color(0xFF8B5CF6)),
        _buildVisualStatCard('Nhiệt độ', '36.8', '°C', Icons.thermostat_rounded, const Color(0xFFFFF7ED), const Color(0xFFF97316)),
        _buildVisualStatCard('Cân nặng', '54', 'kg', Icons.monitor_weight_rounded, const Color(0xFFECFDF5), const Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildVisualStatCard(String label, String value, String unit, IconData icon, Color bgColor, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: bgColor, width: 2),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  unit,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurfaceVariant.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMotherHealthList() {
    return _buildPremiumCard(
      child: Column(
        children: [
          _buildHealthRow(Icons.local_hospital_outlined, 'Phương pháp sinh', 'Sinh thường', const Color(0xFF8B5CF6)),
          const Divider(height: 32, color: Colors.black12),
          _buildHealthRow(Icons.health_and_safety_outlined, 'Bác sĩ phụ trách', 'BS. Minh Hương', const Color(0xFF10B981)),
          const Divider(height: 32, color: Colors.black12),
          _buildHealthRow(Icons.restaurant_outlined, 'Chế độ ăn', 'Giàu đạm & Vitamin', const Color(0xFFF59E0B)),
          const Divider(height: 32, color: Colors.black12),
          _buildHealthRow(Icons.self_improvement_rounded, 'Tâm lý sau sinh', 'Ổn định, tích cực', const Color(0xFFEC4899)),
        ],
      ),
    );
  }

  Widget _buildHealthRow(IconData icon, String title, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurfaceVariant.withOpacity(0.8),
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppTheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildMotherDailyLog() {
    return Column(
      children: [
        _buildLogCard('Dinh dưỡng buổi sáng', 'Cháo gà & Nước cam', '07:30', Icons.restaurant_rounded, const Color(0xFF10B981)),
        const SizedBox(height: 12),
        _buildLogCard('Uống nước', 'Ly thứ 4 (250ml)', '09:00', Icons.water_drop_rounded, const Color(0xFF0EA5E9)),
        const SizedBox(height: 12),
        _buildLogCard('Tập luyện nhẹ', 'Đi bộ tại chỗ 10p', '10:15', Icons.directions_run_rounded, const Color(0xFFF97316)),
      ],
    );
  }

  // ─── BABY SPECIFIC ────────────────────────────────────────────────────────

  Widget _buildBabyHero() {
    return _buildPremiumCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                  ],
                ),
                child: const Center(
                  child: Text('👶', style: TextStyle(fontSize: 42)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Bảo An',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bé gái · Sinh 14/03/2026',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0284C7).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Phát triển bình thường',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0284C7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              _buildMiniBox(Icons.scale_outlined, '3.4 kg', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
              const SizedBox(width: 12),
              _buildMiniBox(Icons.straighten_rounded, '51 cm', const Color(0xFFF0FDF4), const Color(0xFF16A34A)),
              const SizedBox(width: 12),
              _buildMiniBox(Icons.child_care_rounded, '12 ng', const Color(0xFFFDF2F2), const Color(0xFFDC2626)),
              const SizedBox(width: 12),
              _buildMiniBox(Icons.bloodtype_outlined, 'A+', const Color(0xFFFEF2F2), const Color(0xFFDC2626)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBabyStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2,
      children: [
        _buildVisualStatCard('Số lần bú', '8', 'lần', Icons.local_drink_rounded, const Color(0xFFFFF7ED), const Color(0xFFF97316)),
        _buildVisualStatCard('Giấc ngủ', '16', 'giờ', Icons.nights_stay_rounded, const Color(0xFFF5F3FF), const Color(0xFF8B5CF6)),
        _buildVisualStatCard('Nhiệt độ', '36.9', '°C', Icons.thermostat_rounded, const Color(0xFFFDF2F2), const Color(0xFFEF4444)),
        _buildVisualStatCard('Tã thay', '6', 'lần', Icons.baby_changing_station, const Color(0xFFECFDF5), const Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildBabyMilestoneList() {
    return _buildPremiumCard(
      child: Column(
        children: [
          _buildMilestoneRow('Phản xạ bú tốt', 'Đã đạt', true, Icons.check_circle_rounded),
          const Divider(height: 32, color: Colors.black12),
          _buildMilestoneRow('Biết nhìn theo vật', 'Đã đạt', true, Icons.visibility_rounded),
          const Divider(height: 32, color: Colors.black12),
          _buildMilestoneRow('Tự nâng đầu', 'Đang tập', false, Icons.child_care_rounded),
          const Divider(height: 32, color: Colors.black12),
          _buildMilestoneRow('Tiêm chủng BCG', 'Đã tiêm', true, Icons.vaccines_rounded),
        ],
      ),
    );
  }

  Widget _buildMilestoneRow(String title, String status, bool achieved, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: achieved ? AppTheme.primary : AppTheme.onSurfaceVariant.withOpacity(0.3)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurfaceVariant.withOpacity(0.8),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: achieved ? AppTheme.primary.withOpacity(0.1) : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: achieved ? AppTheme.primary : AppTheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBabyDailyLog() {
    return Column(
      children: [
        _buildLogCard('Bú lần gần nhất', '120ml sữa mẻ', '11:30', Icons.local_drink_rounded, const Color(0xFFF97316)),
        const SizedBox(height: 12),
        _buildLogCard('Tắm & Massage', 'Chuyên gia Trần Hà', '08:30', Icons.bathtub_rounded, const Color(0xFF0EA5E9)),
        const SizedBox(height: 12),
        _buildLogCard('Thay tã & Vệ sinh', 'Da khô thoáng', '10:00', Icons.baby_changing_station, const Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildLogCard(String title, String subtitle, String time, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppTheme.onSurfaceVariant.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}




