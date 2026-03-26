import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shader_background.dart';
import '../theme/app_theme.dart';
import '../widgets/dock_nav_bar.dart';
import '../utils/responsive.dart';
import 'care_screen.dart';
import 'community_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Start with 'Trang chủ' (Index 0)
  int _selectedDateIndex = 1; // Default to Tuesday for demo

  // Mock data for 7 days
  final List<List<Map<String, String>>> _weeklySchedules = [
    // T2 (0) - No schedule
    [],
    // T3 (1) - 2 schedules
    [
      {'time': '09:00 - 13:00', 'role': 'Điều dưỡng sau sinh', 'staffName': 'Sarah Chen', 'initials': 'SC', 'status': 'Đã xong'},
      {'time': '14:00 - 16:00', 'role': 'Chuyên gia sữa mẹ', 'staffName': 'Maria Santos', 'initials': 'MS', 'status': 'Sắp tới'},
    ],
    // T4 (2) - 1 schedule
    [
      {'time': '10:00 - 12:00', 'role': 'Bác sĩ Nhi khoa', 'staffName': 'BS. Tuấn', 'initials': 'BT', 'status': 'Sắp tới'},
    ],
    // T5 (3) - No schedule
    [],
    // T6 (4) - 2 schedules
    [
      {'time': '08:30 - 10:30', 'role': 'Kiểm tra sức khỏe', 'staffName': 'Nguyễn Hoa', 'initials': 'NH', 'status': 'Đã lên lịch'},
      {'time': '15:00 - 17:00', 'role': 'Tắm bé & Massage', 'staffName': 'Trần Hà', 'initials': 'TH', 'status': 'Đã lên lịch'},
    ],
    // T7 (5) - No schedule
    [],
    // CN (6) - 1 schedule
    [
      {'time': '09:00 - 10:30', 'role': 'Chuyên gia giấc ngủ', 'staffName': 'Mai Phương', 'initials': 'MP', 'status': 'Đã lên lịch'},
    ],
  ];

  final List<String> _navLabels = [
    'Trang chủ',
    'Chăm sóc',
    'Bé yêu',
    'Cộng đồng',
    'Kiến thức',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildMainHomeContent(), // Index 0: Trang chủ
      _buildPlaceholderScreen('Gói chăm sóc'), // Restore slot but as placeholder
      _buildPlaceholderScreen('Bé yêu'),
      const CommunityScreen(),
      _buildPlaceholderScreen('Kiến thức'),

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

          // Custom Dock Bottom Navigation Bar
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
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderScreen(String title) {
    return ShaderBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_rounded, size: 64, color: AppTheme.primary.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tính năng đang được phát triển',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainHomeContent() {
    final theme = Theme.of(context);
    final Color systemGreen = AppTheme.primary;
    final Color darkText = AppTheme.onSurface;
    final Color greyText = AppTheme.onSurfaceVariant;

    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.1,
    );

    return ShaderBackground(
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Header Section
            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Chào',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: greyText,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('👋', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Text(
                            'Mason James',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildNotificationBell(),
                  ],
                ),
              ),
            ),

            // 1.5 Baby Status Section
            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: _buildBabyStatusSection(),
                  ),
                ),
              ),
            ),

            // 1.6 Current Package Section
            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: _buildSubscriptionSection(),
                  ),
                ),
              ),
            ),

            // 2. Schedule Card Section
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      children: [
                        _buildScheduleCard(systemGreen, darkText, greyText),
                      ],
                    ),
                  ),
                ),
              ),
            ),



            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 4. Baby Section Title
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Text(
                      'Điều cần cho bé',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: Responsive.value(context, mobile: 20, tablet: 28),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // 5. Activity Slider Section
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 120), // Left/Right padding handled by PageView
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: _buildActivitySlider(darkText, greyText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitySlider(Color darkText, Color greyText) {
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Ăn uống',
        'subtitle': 'Bé cần bao nhiêu sữa hoặc sữa công thức?',
        'accent': const Color(0xFF90CAF9),
        'image': 'public/baby_bottle.png',
      },
      {
        'title': 'Giấc ngủ',
        'subtitle': 'Khi nào bé bắt đầu ngủ lâu hơn và sâu hơn?',
        'accent': const Color(0xFFFFAB91),
        'image': 'public/baby_sleep.png',
      },
      {
        'title': 'Sức khỏe',
        'subtitle': 'Lịch tiêm chủng và các kiến thức chăm sóc bé.',
        'accent': const Color(0xFFA5D6A7),
        'image': 'public/salad.png',
      },
      {
        'title': 'Vui chơi',
        'subtitle': 'Các trò chơi giúp kích thích trí não và vận động.',
        'accent': const Color(0xFFCE93D8),
        'image': 'public/toy.png',
      },
    ];

    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.1,
    );

    return SizedBox(
      height: 330, // Compact height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding - 8),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final item = activities[index];
          return SizedBox(
            width: Responsive.value(context, mobile: 240, tablet: 280, desktop: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildActivityCard(
                title: item['title'],
                subtitle: item['subtitle'],
                accent: item['accent'],
                imagePath: item['image'],
                darkText: darkText,
                greyText: greyText,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        image: const DecorationImage(
          image: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=Mason'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNotificationBell() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.notifications_none_rounded, color: Colors.black87, size: 24),
    );
  }

  Widget _buildBabyStatusSection() {
    final double gridSpacing = Responsive.value(context, mobile: 12, tablet: 20);
    // Aspect ratio: width / height. A higher number makes the card wider/shorter.
    final double aspectRatio = Responsive.value(
      context, 
      mobile: 2.3, 
      tablet: 3.0,
      desktop: 3.5
    );

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: gridSpacing,
      crossAxisSpacing: gridSpacing,
      childAspectRatio: aspectRatio,
      children: [
        _buildInfoCard(
          label: 'Tuổi của bé',
          value: '12 ngày',
          icon: Icons.child_care_rounded,
          color: const Color(0xFFE3F2FD),
          iconColor: const Color(0xFF1976D2),
        ),
        _buildInfoCard(
          label: 'Cữ bú tiếp theo',
          value: '45 phút',
          icon: Icons.access_time_rounded,
          color: const Color(0xFFFFF3E0),
          iconColor: const Color(0xFFF57C00),
        ),
        _buildInfoCard(
          label: 'Thời gian ngủ',
          value: '6.5 giờ',
          icon: Icons.nights_stay_rounded,
          color: const Color(0xFFF3E5F5),
          iconColor: const Color(0xFF7B1FA2),
        ),
        _buildInfoCard(
          label: 'Tâm trạng',
          value: 'Rất tốt',
          icon: Icons.favorite_rounded,
          color: const Color(0xFFFCE4EC),
          iconColor: const Color(0xFFC2185B),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required Color iconColor,
  }) {
    final double iconSize = Responsive.value(context, mobile: 18, tablet: 22);
    final double fontSizeLabel = Responsive.value(context, mobile: 11, tablet: 13);
    final double fontSizeValue = Responsive.value(context, mobile: 15, tablet: 18);

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.black87, size: iconSize),
                ),
                const SizedBox(width: 10),
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
                          fontSize: fontSizeLabel,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: fontSizeValue,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
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


  Widget _buildSubscriptionSection() {
    const Color creamAccent = Color(0xFFF4E7C6);
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  creamAccent.withOpacity(0.95),
                  creamAccent.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(60),

              border: Border.all(

                color: Colors.white,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.auto_awesome_rounded, color: Colors.orange.shade800, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Gói hiện tại',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.orange.shade900.withOpacity(0.8),
                              letterSpacing: 0.5,
                              textStyle: const TextStyle(height: 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Icon(Icons.stars_rounded, color: Colors.orange.shade700, size: 28),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gói Sơ sinh Toàn diện',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.brown.shade900,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tiến độ: 15/30 ngày',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.brown.shade700.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: _buildBubbleButton(
                    text: 'Xem chi tiết',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CareScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBubbleButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.35),
                    Colors.white.withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  style: GoogleFonts.inter(
                    color: Colors.brown.shade900,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPackagesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Danh sách gói chăm sóc',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    children: [
                      _buildPackageItem(
                        title: 'Gói Sơ sinh Toàn diện',
                        price: '5.900.000đ',
                        duration: '30 ngày',
                        isCurrent: true,
                      ),
                      _buildPackageItem(
                        title: 'Gói Chăm sóc Chuyên sâu',
                        price: '8.500.000đ',
                        duration: '45 ngày',
                      ),
                      _buildPackageItem(
                        title: 'Gói Phục hồi Sau sinh',
                        price: '4.200.000đ',
                        duration: '15 ngày',
                      ),
                      const SizedBox(height: 32),
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

  Widget _buildPackageItem({
    required String title,
    required String price,
    required String duration,
    bool isCurrent = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCurrent ? AppTheme.primary.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCurrent ? AppTheme.primary.withOpacity(0.3) : Colors.black.withOpacity(0.05),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Hiện tại',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Thời gian: $duration',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard(Color accent, Color darkText, Color greyText) {
    final List<String> days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    final List<String> dates = ['24', '25', '26', '27', '28', '29', '30'];
    final selectedEvents = _weeklySchedules[_selectedDateIndex];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0.4),
                ],
              ),
              borderRadius: BorderRadius.circular(60),

              border: Border.all(

                color: Colors.white.withOpacity(0.8),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lịch trình chăm sóc",
                      style: GoogleFonts.inter(
                        fontSize: Responsive.value(context, mobile: 18, tablet: 22),
                        color: darkText.withOpacity(0.85),
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (selectedEvents.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${selectedEvents.length} ca',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: accent,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                // Date Selector
                SizedBox(
                  height: 95,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      final bool isSelected = index == _selectedDateIndex;
                      final bool hasEvent = _weeklySchedules[index].isNotEmpty;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDateIndex = index;
                          });
                        },
                        child: Container(
                          width: Responsive.value(context, mobile: 64, tablet: 74),
                          margin: const EdgeInsets.only(right: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? accent : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: isSelected ? accent.withOpacity(0.5) : Colors.white.withOpacity(0.5),
                              width: 1,
                            ),
                            boxShadow: isSelected ? [
                              BoxShadow(
                                color: accent.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ] : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                days[index],
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : AppTheme.onSurfaceVariant.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dates[index],
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected ? Colors.white : darkText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: hasEvent 
                                      ? (isSelected ? Colors.white : accent.withOpacity(0.8))
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),
                // Events List
                if (selectedEvents.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.event_busy_rounded, size: 40, color: greyText.withOpacity(0.4)),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Hôm nay không có lịch trình nào.',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: greyText.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: selectedEvents.map((event) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _buildStaffSession(
                          time: event['time']!,
                          role: event['role']!,
                          staffName: event['staffName']!,
                          initials: event['initials']!,
                          status: event['status']!,
                          accent: accent,
                          darkText: darkText,
                          greyText: greyText,
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),
                _buildInternalBookingBtn(accent),
              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget _buildStaffSession({
    required String time,
    required String role,
    required String staffName,
    required String initials,
    required String status,
    required Color accent,
    required Color darkText,
    required Color greyText,
  }) {
    final bool isSoon = status == 'Sắp tới';
    final Color statusColor = isSoon ? accent : greyText.withOpacity(0.6);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent.withOpacity(0.2),
                        accent.withOpacity(0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staffName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: darkText.withOpacity(0.9),
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: greyText.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_rounded, color: accent.withOpacity(0.8), size: 14),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              time,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: accent.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(status, statusColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String subtitle,
    required Color accent,
    required String imagePath,
    required Color darkText,
    required Color greyText,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // --- Blurred accent circle (upper-right) ---
            Positioned(
              top: -40,
              left: -40,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 42, sigmaY: 42),
                child: Container(
                  width: 230,
                  height: 250,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // --- 3D Image centered in upper card ---
            Positioned(
              top: 45,
              left: 65,
              right: 15,
              bottom: 95,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),

            // --- Text + arrow overlay ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const Spacer(),

                  // Subtitle + Arrow row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.45),
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Arrow button
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.08),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.06),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.north_east_rounded,
                          size: 18,
                          color: Colors.black45,
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
    );
  }

  Widget _buildInternalBookingBtn(Color accent) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              'Đặt lịch chăm sóc',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCTA() {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),

        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primary,
                  AppTheme.primary.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(60),

              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bạn cần tư vấn thêm?',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Hẹn lịch ngay hôm nay',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Text(
                    'Hẹn lịch',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
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

