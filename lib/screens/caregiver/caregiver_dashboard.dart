import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import '../../widgets/dock_nav_bar.dart';

class CaregiverDashboard extends StatefulWidget {
  const CaregiverDashboard({super.key});

  @override
  State<CaregiverDashboard> createState() => _CaregiverDashboardState();
}

class _CaregiverDashboardState extends State<CaregiverDashboard> {
  int _currentIndex = 0;

  final List<String> _navLabels = [
    'Tổng quan',
    'Lịch làm việc',
    'Khách hàng',
    'Thu nhập',
    'Tài khoản',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildHomeTab(),
      _buildPlaceholder('Lịch làm việc'),
      _buildPlaceholder('Khách hàng'),
      _buildPlaceholder('Thu nhập'),
      _buildPlaceholder('Tài khoản'),
    ];

    final double navWidth = Responsive.value(
      context,
      mobile: Responsive.getWidth(context) - 48,
      tablet: 500,
      desktop: 600,
    );

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Center(
              child: SizedBox(
                width: navWidth,
                child: DockNavBar(
                  currentIndex: _currentIndex,
                  navLabels: _navLabels,
                  onTap: (index) => setState(() => _currentIndex = index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String title) {
    return ShaderBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_rounded, size: 64, color: AppTheme.primary.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Tính năng đang được phát triển',
              style: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    final double pad = Responsive.value(context, mobile: 24, tablet: 40);

    return ShaderBackground(
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Header ────────────────────────────────────────
            SliverPadding(
              padding: EdgeInsets.fromLTRB(pad, 16, pad, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=Caregiver'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Xin chào 👋', style: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurfaceVariant)),
                            ],
                          ),
                          Text(
                            'Nguyễn Thị Hoa',
                            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.onSurface),
                          ),
                        ],
                      ),
                    ),
                    _buildIconButton(Icons.notifications_none_rounded),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // ── Status Banner ─────────────────────────────────
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              sliver: SliverToBoxAdapter(child: _buildStatusBanner()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // ── Stats Grid ────────────────────────────────────
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              sliver: SliverToBoxAdapter(child: _buildStatsGrid()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ── Today's Schedule ──────────────────────────────
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Lịch hôm nay',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.onSurface),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              sliver: SliverToBoxAdapter(child: _buildTodaySchedule()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ── Assigned Clients ──────────────────────────────
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Khách hàng đang phụ trách',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.onSurface),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(pad, 0, pad, 120),
              sliver: SliverToBoxAdapter(child: _buildClientList()),
            ),
          ],
        ),
      ),
    );
  }

  // ── Status Banner ─────────────────────────────────────────────────────────

  Widget _buildStatusBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primary.withOpacity(0.25),
                AppTheme.primary.withOpacity(0.10),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppTheme.primary.withOpacity(0.35), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.verified_rounded, color: AppTheme.primary, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đang hoạt động',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.onSurface),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Điều dưỡng sau sinh · Cấp độ Senior',
                      style: GoogleFonts.inter(fontSize: 13, color: AppTheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '4.9 ⭐',
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stats Grid ────────────────────────────────────────────────────────────

  Widget _buildStatsGrid() {
    const double spacing = 12;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      childAspectRatio: 2.2,
      children: [
        _buildStatCard(label: 'Ca hôm nay', value: '3 ca', icon: Icons.work_outline_rounded, color: const Color(0xFFE8F5E9), iconColor: const Color(0xFF388E3C)),
        _buildStatCard(label: 'Khách đang chăm', value: '5 mẹ', icon: Icons.people_outline_rounded, color: const Color(0xFFFFF3E0), iconColor: const Color(0xFFF57C00)),
        _buildStatCard(label: 'Tháng này', value: '18.5h', icon: Icons.timer_outlined, color: const Color(0xFFE3F2FD), iconColor: const Color(0xFF1976D2)),
        _buildStatCard(label: 'Đánh giá', value: '4.9/5', icon: Icons.star_outline_rounded, color: const Color(0xFFFCE4EC), iconColor: const Color(0xFFC2185B)),
      ],
    );
  }

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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
                    Text(value, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Today's Schedule ──────────────────────────────────────────────────────

  Widget _buildTodaySchedule() {
    final List<Map<String, dynamic>> schedule = [
      {'time': '08:00 - 10:00', 'client': 'Nguyễn Thị Lan', 'task': 'Chăm sóc mẹ sau sinh', 'status': 'Đã xong', 'statusColor': const Color(0xFF388E3C)},
      {'time': '11:00 - 13:00', 'client': 'Trần Thị Mai', 'task': 'Tắm bé & Massage', 'status': 'Đang làm', 'statusColor': const Color(0xFF1976D2)},
      {'time': '15:00 - 17:00', 'client': 'Lê Thị Hằng', 'task': 'Tư vấn nuôi con bằng sữa mẹ', 'status': 'Sắp tới', 'statusColor': const Color(0xFFF57C00)},
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.6)),
          ),
          child: Column(
            children: schedule.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['time'], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant)),
                            const SizedBox(height: 2),
                            Text(item['client'], style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: AppTheme.onSurface)),
                            Text(item['task'], style: GoogleFonts.inter(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: (item['statusColor'] as Color).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['status'],
                            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: item['statusColor']),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < schedule.length - 1)
                    Divider(height: 1, color: Colors.black12),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ── Client List ───────────────────────────────────────────────────────────

  Widget _buildClientList() {
    final List<Map<String, dynamic>> clients = [
      {'name': 'Nguyễn Thị Lan', 'detail': 'Mẹ sau sinh · 12 ngày', 'package': 'Gói 30 Ngày', 'avatar': 'MomAoI', 'progress': 0.4},
      {'name': 'Trần Thị Mai', 'detail': 'Mẹ sau sinh · 5 ngày', 'package': 'Gói 15 Ngày', 'avatar': 'Mai', 'progress': 0.33},
      {'name': 'Lê Thị Hằng', 'detail': 'Mẹ sau sinh · 20 ngày', 'package': 'Gói 30 Ngày', 'avatar': 'Hang', 'progress': 0.67},
    ];

    return Column(
      children: clients.map((c) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.45),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.6)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                        image: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=${c['avatar']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c['name'], style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
                        Text(c['detail'], style: GoogleFonts.inter(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: c['progress'],
                                  backgroundColor: AppTheme.progressBackground,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                                  minHeight: 4,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${(c['progress'] * 100).toInt()}%',
                              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Icon(icon, color: AppTheme.onSurface, size: 22),
    );
  }
}




