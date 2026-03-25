import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shader_background.dart';
import '../theme/app_theme.dart';
import '../widgets/dock_nav_bar.dart';
import '../utils/responsive.dart';
import 'care_screen.dart';

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
      const CareScreen(),
      _buildPlaceholderScreen('Bé yêu'),
      _buildPlaceholderScreen('Cộng đồng'),
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

            // 2. Schedule Card Section
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: _buildScheduleCard(systemGreen, darkText, greyText),
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

  Widget _buildScheduleCard(Color accent, Color darkText, Color greyText) {
    final List<String> days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    final List<String> dates = ['24', '25', '26', '27', '28', '29', '30'];
    final selectedEvents = _weeklySchedules[_selectedDateIndex];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 40,
            spreadRadius: -10,
            offset: const Offset(0, 20),
          ),
        ],
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
                  color: darkText.withOpacity(0.9),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              if (selectedEvents.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${selectedEvents.length} ca',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          // Date Selector
          SizedBox(
            height: 90,
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
                    width: Responsive.value(context, mobile: 60, tablet: 70),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? accent : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? accent : Colors.black12,
                        width: 1,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: accent.withOpacity(0.3),
                          blurRadius: 10,
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
                            color: isSelected ? Colors.white : AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dates[index],
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isSelected ? Colors.white : darkText,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: hasEvent 
                                ? (isSelected ? Colors.white : accent)
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
          const SizedBox(height: 24),
          // Events List
          if (selectedEvents.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Icon(Icons.event_busy_rounded, size: 48, color: greyText.withOpacity(0.3)),
                    const SizedBox(height: 12),
                    Text(
                      'Hôm nay không có lịch trình nào.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: greyText,
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
                  padding: const EdgeInsets.only(bottom: 12),
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
        ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              shape: BoxShape.circle,
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staffName,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: greyText,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time_filled_rounded, color: accent, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: accent,
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
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    if (Responsive.isMobile(context) && status.length > 8) {
       // Shorten or hide for very small screens if needed
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
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
                  width: 300,
                  height: 300,
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
}
