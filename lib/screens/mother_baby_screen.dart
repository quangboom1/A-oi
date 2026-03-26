import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/shader_background.dart';

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
      mobile: 24,
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
              // ── Header ──────────────────────────────────────
              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 20, horizontalPadding, 0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hồ sơ',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppTheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              'Mẹ & Bé',
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.onSurface,
                                letterSpacing: -0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildHeaderIcon(Icons.edit_outlined),
                      const SizedBox(width: 12),
                      _buildHeaderIcon(Icons.more_horiz_rounded),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── Tab Switcher ─────────────────────────────────
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: _buildTabSwitcher(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // ── Profile Hero Card ─────────────────────────────
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: _selectedTab == 0
                      ? _buildMotherHeroCard()
                      : _buildBabyHeroCard(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              // ── Quick Stats Grid ──────────────────────────────
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: _selectedTab == 0
                      ? _buildMotherStatsGrid()
                      : _buildBabyStatsGrid(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── Section Title ─────────────────────────────────
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    _selectedTab == 0 ? 'Sức khoẻ của mẹ' : 'Cột mốc phát triển',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // ── Detail List ───────────────────────────────────
              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 12),
                sliver: SliverToBoxAdapter(
                  child: _selectedTab == 0
                      ? _buildMotherHealthList()
                      : _buildBabyMilestoneList(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // ── Daily Log Section ─────────────────────────────
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    _selectedTab == 0 ? 'Nhật ký hôm nay' : 'Theo dõi hôm nay',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              SliverPadding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 120),
                sliver: SliverToBoxAdapter(
                  child: _selectedTab == 0
                      ? _buildMotherDailyLog()
                      : _buildBabyDailyLog(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Shared Helpers ────────────────────────────────────────────────────────

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Icon(icon, size: 20, color: AppTheme.onSurface),
    );
  }

  Widget _buildTabSwitcher() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              _buildTab(0, 'Thông tin Mẹ'),
              _buildTab(1, 'Thông tin Bé'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final bool isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
          setState(() => _selectedTab = index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isActive ? Colors.white : AppTheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child, EdgeInsets? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.white.withOpacity(0.6)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color.withOpacity(0.7),
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.onSurfaceVariant,
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
      ),
    );
  }

  Widget _buildLogItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    String? tag,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
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
                    color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          if (tag != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tag,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─── MOTHER TAB ────────────────────────────────────────────────────────────

  Widget _buildMotherHeroCard() {
    return _buildGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: const DecorationImage(
                    image: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=MomAoI'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Thị Lan',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mẹ sau sinh · 12 ngày',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Đang hồi phục tốt',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.black12),
          const Divider(color: Colors.black12),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.3,
            children: [
              _buildInfoChip(icon: Icons.cake_outlined, label: 'Tuổi', value: '28 tuổi', color: const Color(0xFFE91E63)),
              _buildInfoChip(icon: Icons.monitor_weight_outlined, label: 'Cân nặng', value: '54 kg', color: const Color(0xFF3F51B5)),
              _buildInfoChip(icon: Icons.straighten_rounded, label: 'Chiều cao', value: '162 cm', color: const Color(0xFF009688)),
              _buildInfoChip(icon: Icons.bloodtype_outlined, label: 'Nhóm máu', value: 'A+', color: const Color(0xFFF44336)),
            ],
          ),
        ],
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
      childAspectRatio: 2.3,
      children: [
        _buildStatCard(label: 'Huyết áp', value: '110/70', icon: Icons.favorite_rounded, color: const Color(0xFFFCE4EC), iconColor: const Color(0xFFC2185B)),
        _buildStatCard(label: 'Nhịp tim', value: '74 bpm', icon: Icons.monitor_heart_outlined, color: const Color(0xFFF3E5F5), iconColor: const Color(0xFF7B1FA2)),
        _buildStatCard(label: 'Nhiệt độ', value: '36.8°C', icon: Icons.thermostat_rounded, color: const Color(0xFFFFF3E0), iconColor: const Color(0xFFF57C00)),
        _buildStatCard(label: 'Đo ngày', value: 'Hôm nay', icon: Icons.calendar_today_rounded, color: const Color(0xFFE8F5E9), iconColor: const Color(0xFF388E3C)),
      ],
    );
  }

  Widget _buildMotherHealthList() {
    return _buildGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildDetailRow(icon: Icons.local_hospital_outlined, label: 'Phương pháp sinh', value: 'Thường', iconColor: const Color(0xFF7B1FA2)),
          _buildDetailRow(icon: Icons.medical_services_outlined, label: 'Bác sĩ phụ trách', value: 'BS. Hương', iconColor: AppTheme.primary),
          _buildDetailRow(icon: Icons.vaccines_outlined, label: 'Tình trạng cho bú', value: 'Đang cho bú', iconColor: const Color(0xFFF57C00)),
          _buildDetailRow(icon: Icons.medication_liquid_outlined, label: 'Thuốc bổ sung', value: 'Sắt, DHA', iconColor: const Color(0xFF1976D2)),
          _buildDetailRow(icon: Icons.self_improvement_rounded, label: 'Bài tập hồi phục', value: '10 phút/ngày', iconColor: const Color(0xFF388E3C)),
          _buildDetailRow(icon: Icons.psychology_outlined, label: 'Tâm lý sau sinh', value: 'Ổn định', iconColor: const Color(0xFF00897B)),
        ],
      ),
    );
  }

  Widget _buildMotherDailyLog() {
    return _buildGlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildLogItem(icon: Icons.water_drop_rounded, title: 'Uống nước', subtitle: '08:00 sáng', color: const Color(0xFF1976D2), tag: '1.8L / 2.5L'),
          _buildLogItem(icon: Icons.restaurant_rounded, title: 'Bữa sáng', subtitle: '07:30 sáng · Cháo gà, rau củ', color: const Color(0xFF388E3C), tag: 'Đủ chất'),
          _buildLogItem(icon: Icons.bedtime_rounded, title: 'Giấc ngủ đêm', subtitle: '10:00 PM – 04:30 AM', color: const Color(0xFF5C6BC0), tag: '6.5 giờ'),
          _buildLogItem(icon: Icons.healing_outlined, title: 'Vết thương tầng sinh môn', subtitle: 'Kiểm tra buổi sáng', color: const Color(0xFFC2185B), tag: 'Lành tốt'),
          _buildLogItem(icon: Icons.mood_rounded, title: 'Tâm trạng', subtitle: 'Tự đánh giá lúc 09:00', color: AppTheme.primary, tag: 'Tốt'),
        ],
      ),
    );
  }

  // ─── BABY TAB ──────────────────────────────────────────────────────────────

  Widget _buildBabyHeroCard() {
    return _buildGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Center(
                  child: Text('👶', style: TextStyle(fontSize: 38)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Bảo An',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bé gái · Sinh ngày 14/03/2026',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Phát triển bình thường',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1976D2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.black12),
          const Divider(color: Colors.black12),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.3,
            children: [
              _buildInfoChip(icon: Icons.scale_outlined, label: 'Cân nặng', value: '3.4 kg', color: const Color(0xFF1976D2)),
              _buildInfoChip(icon: Icons.straighten_rounded, label: 'Chiều dài', value: '51 cm', color: const Color(0xFF009688)),
              _buildInfoChip(icon: Icons.child_care_rounded, label: 'Tuần tuổi', value: '12 ngày', color: AppTheme.primary),
              _buildInfoChip(icon: Icons.bloodtype_outlined, label: 'Nhóm máu', value: 'A+', color: const Color(0xFFF44336)),
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
      childAspectRatio: 2.3,
      children: [
        _buildStatCard(label: 'Số lần bú', value: '8 lần', icon: Icons.local_drink_rounded, color: const Color(0xFFFFF3E0), iconColor: const Color(0xFFF57C00)),
        _buildStatCard(label: 'Thời gian ngủ', value: '16 giờ', icon: Icons.nights_stay_rounded, color: const Color(0xFFF3E5F5), iconColor: const Color(0xFF7B1FA2)),
        _buildStatCard(label: 'Nhiệt độ', value: '36.9°C', icon: Icons.thermostat_rounded, color: const Color(0xFFFCE4EC), iconColor: const Color(0xFFC2185B)),
        _buildStatCard(label: 'Tã thay', value: '6 lần', icon: Icons.baby_changing_station, color: const Color(0xFFE8F5E9), iconColor: const Color(0xFF388E3C)),
      ],
    );
  }

  Widget _buildBabyMilestoneList() {
    return _buildGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildMilestoneItem(label: 'Tự nâng đầu', status: 'Chưa đạt', isAchieved: false, icon: Icons.child_care_rounded),
          _buildMilestoneItem(label: 'Phản xạ bú tốt', status: 'Đã đạt', isAchieved: true, icon: Icons.local_drink_rounded),
          _buildMilestoneItem(label: 'Tiêm BCG & VGB', status: 'Đã tiêm', isAchieved: true, icon: Icons.vaccines_outlined),
          _buildMilestoneItem(label: 'Nghe theo giọng mẹ', status: 'Đang phát triển', isAchieved: false, icon: Icons.hearing_rounded),
          _buildMilestoneItem(label: 'Tăng cân đều', status: 'Đang tốt', isAchieved: true, icon: Icons.trending_up_rounded),
          _buildMilestoneItem(label: 'Khám sơ sinh', status: 'Đã khám 14/03', isAchieved: true, icon: Icons.medical_services_outlined),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem({
    required String label,
    required String status,
    required bool isAchieved,
    required IconData icon,
  }) {
    final Color color = isAchieved ? AppTheme.primary : AppTheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurface,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBabyDailyLog() {
    return _buildGlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildLogItem(icon: Icons.local_drink_rounded, title: 'Bú lần 1', subtitle: '06:00 sáng · 15 phút', color: const Color(0xFFF57C00), tag: 'Bú tốt'),
          _buildLogItem(icon: Icons.local_drink_rounded, title: 'Bú lần 2', subtitle: '09:30 sáng · 10 phút', color: const Color(0xFFF57C00), tag: 'Bú tốt'),
          _buildLogItem(icon: Icons.baby_changing_station, title: 'Thay tã', subtitle: '07:00, 10:00, 12:00', color: const Color(0xFF388E3C), tag: '3 lần'),
          _buildLogItem(icon: Icons.bathtub_outlined, title: 'Tắm bé', subtitle: '08:30 sáng · Sarah Chen', color: const Color(0xFF1976D2), tag: 'Hoàn thành'),
          _buildLogItem(icon: Icons.nights_stay_rounded, title: 'Giấc ngủ', subtitle: 'Tổng 8 tiếng đêm qua', color: const Color(0xFF7B1FA2), tag: '😌 Ngủ ngon'),
        ],
      ),
    );
  }

  // ─── Shared Stat Card ──────────────────────────────────────────────────────

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Icon(icon, color: Colors.black87, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black54)),
                      const SizedBox(height: 1),
                      Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87)),
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
}
