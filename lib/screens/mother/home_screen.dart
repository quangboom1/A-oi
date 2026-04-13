import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/shader_background.dart';
import '../../widgets/main_header.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dock_nav_bar.dart';
import '../../utils/responsive.dart';
import 'care_screen.dart';
import 'booking_screen.dart';
import 'community_screen.dart';
import 'mother_baby_screen.dart';
import 'knowledge_screen.dart';
import 'booking_history_screen.dart';
import 'caregiver_detail_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Start with 'Trang chủ' (Index 0)
  int _selectedDateIndex = 1; // Default to Tuesday for demo

  // Mock data for 7 days
  final List<List<Map<String, dynamic>>> _weeklySchedules = [
    // T2 (0) - No schedule
    [],
    // T3 (1) - 2 schedules
    [
      {
        'time': '09:00 - 13:00', 
        'role': 'Điều dưỡng sau sinh', 
        'staffName': 'Nguyễn Thị Mai', 
        'initials': 'NM', 
        'status': 'Đã xong',
        'image': 'assets/images/cavegiver (1).png',
        'rating': 4.9,
        'reviewCount': 128,
        'accent': const Color(0xFF90CAF9),
        'bio': '7 năm kinh nghiệm chăm sóc mẹ và bé sau sinh tại Lê Duẩn, Đà Nẵng.',
        'specialties': ['Chăm sóc vết mổ', 'Hỗ trợ tắm bé', 'Tư vấn dinh dưỡng'],
      },
      {
        'time': '14:00 - 16:00', 
        'role': 'Chuyên gia sữa mẹ', 
        'staffName': 'Trần Thu Hương', 
        'initials': 'TH', 
        'status': 'Sắp tới',
        'image': 'assets/images/cavegiver (2).png',
        'rating': 4.8,
        'reviewCount': 95,
        'accent': const Color(0xFFF48FB1),
        'bio': 'Chuyên gia tư vấn nuôi con bằng sữa mẹ với chứng chỉ quốc tế IBCLC hiện đang công tác tại Lê Duẩn, Đà Nẵng.',
        'specialties': ['Thông tắc tia sữa', 'Tư vấn lên sữa', 'Cách bú đúng tư thế'],
      },
    ],
    // T4 (2) - 1 schedule
    [
      {
        'time': '10:00 - 12:00', 
        'role': 'Bác sĩ Nhi khoa', 
        'staffName': 'BS. Tuấn', 
        'initials': 'BT', 
        'status': 'Sắp tới',
        'image': 'assets/images/cavegiver (1).png', 
        'rating': 4.9,
        'reviewCount': 210,
        'accent': const Color(0xFF90CAF9),
        'bio': 'Bác sĩ chuyên khoa Nhi với 15 năm kinh nghiệm điều trị và tư vấn sức khỏe trẻ sơ sinh.',
        'specialties': ['Khám nhi tổng quát', 'Tư vấn tiêm chủng', 'Điều trị bệnh lý sơ sinh'],
      },
    ],
    // T5 (3) - No schedule
    [],
    // T6 (4) - 2 schedules
    [
      {
        'time': '08:30 - 10:30', 
        'role': 'Kiểm tra sức khỏe', 
        'staffName': 'Lê Phương Thảo', 
        'initials': 'PT', 
        'status': 'Đã lên lịch',
        'image': 'assets/images/cavegiver (3).png',
        'rating': 4.7,
        'reviewCount': 74,
        'accent': const Color(0xFFFFAB91),
        'bio': '5 năm kinh nghiệm massage phục hồi sau sinh và giảm eo chuyên sâu cho các mẹ tại Lê Duẩn, Đà Nẵng.',
        'specialties': ['Massage bụng giảm eo', 'Phục hồi cơ thể', 'Giảm đau vai gáy'],
      },
      {
        'time': '15:00 - 17:00', 
        'role': 'Tắm bé & Massage', 
        'staffName': 'Phạm Ngọc Anh', 
        'initials': 'NA', 
        'status': 'Đã lên lịch',
        'image': 'assets/images/cavegiver (4).png',
        'rating': 4.9,
        'reviewCount': 112,
        'accent': const Color(0xFFA5D6A7),
        'bio': 'Điều dưỡng nhi khoa với 9 năm kinh nghiệm, chuyên theo dõi phát triển trẻ sơ sinh tại Lê Duẩn, Đà Nẵng.',
        'specialties': ['Kiểm tra sức khoẻ bé', 'Tắm bé & massage bé', 'Theo dõi cân nặng'],
      },
    ],
    // T7 (5) - No schedule
    [],
    // CN (6) - 1 schedule
    [
      {
        'time': '09:00 - 10:30', 
        'role': 'Chuyên gia giấc ngủ', 
        'staffName': 'Hoàng Lan Chi', 
        'initials': 'LC', 
        'status': 'Đã lên lịch',
        'image': 'assets/images/cavegiver (5).png',
        'rating': 4.6,
        'reviewCount': 61,
        'accent': const Color(0xFFCE93D8),
        'bio': 'Tư vấn giấc ngủ cho trẻ sơ sinh, giúp bé ngủ xuyên đêm từ tuần thứ 6, chuyên gia hàng đầu tại Lê Duẩn, Đà Nẵng.',
        'specialties': ['Lịch ngủ sinh học', 'Giảm quấy khóc', 'Phương pháp ru ngủ'],
      },
    ],
  ];

  final List<String> _navLabels = [
    'Trang chủ',
    'Lịch sử',
    'Bé yêu',
    'Cộng đồng',
    'Kiến thức',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildMainHomeContent(), // Index 0: Trang chủ
      const BookingHistoryScreen(), // Index 1: Lịch sử đặt lịch
      const MotherBabyScreen(),
      const CommunityScreen(),
      const KnowledgeScreen(),
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
            SliverToBoxAdapter(
              child: MainHeader(horizontalPadding: horizontalPadding),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

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
        'image': 'assets/images/baby_bottle.png',
      },
      {
        'title': 'Giấc ngủ',
        'subtitle': 'Khi nào bé bắt đầu ngủ lâu hơn và sâu hơn?',
        'accent': const Color(0xFFFFAB91),
        'image': 'assets/images/baby_sleep.png',
      },
      {
        'title': 'Sức khỏe',
        'subtitle': 'Lịch tiêm chủng và các kiến thức chăm sóc bé.',
        'accent': const Color(0xFFA5D6A7),
        'image': 'assets/images/salad.png',
      },
      {
        'title': 'Vui chơi',
        'subtitle': 'Các trò chơi giúp kích thích trí não và vận động.',
        'accent': const Color(0xFFCE93D8),
        'image': 'assets/images/toy.png',
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
    const Color creamAccent = AppTheme.c100;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
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
              color: Colors.black12,
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




  Widget _buildScheduleCard(Color accent, Color darkText, Color greyText) {
    final List<String> days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    final List<String> dates = ['24', '25', '26', '27', '28', '29', '30'];
    final selectedEvents = _weeklySchedules[_selectedDateIndex];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              color: Colors.white.withOpacity(0.6),
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
                          color: accent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: accent.withOpacity(0.1),
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
                          event: event,
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
    required Map<String, dynamic> event,
    required Color accent,
    required Color darkText,
    required Color greyText,
  }) {
    final String time = event['time'] ?? '';
    final String role = event['role'] ?? '';
    final String staffName = event['staffName'] ?? '';
    final String image = event['image'] ?? 'assets/images/cavegiver (1).png';
    final String status = event['status'] ?? '';
    final Color cgAccent = event['accent'] ?? accent;

    final bool isSoon = status == 'Sắp tới';
    final Color statusColor = isSoon ? cgAccent : greyText.withOpacity(0.6);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 450),
            reverseTransitionDuration: const Duration(milliseconds: 350),
            pageBuilder: (_, __, ___) => CaregiverDetailScreen(
              name: staffName,
              role: role,
              initials: event['initials'] ?? '',
              rating: (event['rating'] as num?)?.toDouble() ?? 5.0,
              reviewCount: event['reviewCount'] ?? 0,
              accent: cgAccent,
              bio: event['bio'] ?? '',
              specialties: List<String>.from(event['specialties'] ?? []),
              image: image,
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
      child: Container(
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
                  Hero(
                    tag: 'caregiver_avatar_$staffName',
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: cgAccent.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
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
                            Icon(Icons.access_time_filled_rounded, color: cgAccent.withOpacity(0.8), size: 14),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                time,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: cgAccent.withOpacity(0.9),
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
                            color: Colors.black45,
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
                            color: Colors.black12,
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BookingScreen()),
        );
      },
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

}





