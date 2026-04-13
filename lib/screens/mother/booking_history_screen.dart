import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import '../../widgets/main_header.dart';
import 'booking_detail_screen.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      desktop: Responsive.getWidth(context) * 0.15,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(horizontalPadding: horizontalPadding),
              
              // Header Section
              Padding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lịch sử đặt lịch',
                      style: GoogleFonts.inter(
                        fontSize: Responsive.value(context, mobile: 28, tablet: 32),
                        fontWeight: FontWeight.w800,
                        color: AppTheme.onSurface,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Quản lý các dịch vụ chăm sóc đã đặt',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: AppTheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Glass Tab Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.6)),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppTheme.onSurface.withOpacity(0.5),
                    labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13),
                    unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                    tabs: const [
                      Tab(text: 'Sắp tới'),
                      Tab(text: 'Lịch sử'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Content View
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBookingList(upcoming: true, padding: horizontalPadding),
                    _buildBookingList(upcoming: false, padding: horizontalPadding),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList({required bool upcoming, required double padding}) {
    final items = upcoming ? _upcomingBookings : _pastBookings;

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.event_busy_rounded, size: 48, color: AppTheme.onSurface.withOpacity(0.3)),
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có lịch đặt nào',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurface.withOpacity(0.4),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 120),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(items[index]);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> item) {
    final Color accentColor = item['color'] as Color;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailScreen(booking: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60), // Requirement: bo góc 60
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60), // Requirement: bo góc 60
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.45),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item['category'],
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: accentColor,
                          ),
                        ),
                      ),
                      Text(
                        item['date'],
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    item['title'],
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, size: 14, color: AppTheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        item['location'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppTheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(item['caregiverAvatar']),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['caregiverName'],
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.onSurface,
                              ),
                            ),
                            Text(
                              item['caregiverRole'],
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (item['status'] == 'completed')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Colors.green, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'Đã xong',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.primary),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _upcomingBookings = [
    {
      'title': 'Tư vấn sữa mẹ',
      'category': 'Chuyên sâu',
      'date': '05 Th4 | 09:00',
      'location': 'Lê Duẩn, Đà Nẵng',
      'color': const Color(0xFFF48FB1),
      'caregiverName': 'Trần Thu Hương',
      'caregiverRole': 'Chuyên gia sữa mẹ',
      'caregiverAvatar': 'assets/images/cavegiver (2).png',
      'status': 'upcoming',
      'initials': 'TH',
      'rating': 4.8,
      'reviewCount': 95,
      'bio': 'Chuyên gia tư vấn nuôi con bằng sữa mẹ với chứng chỉ quốc tế IBCLC hiện đang công tác tại Hải Châu, Đà Nẵng.',
      'specialties': ['Thông tắc tia sữa', 'Tư vấn lên sữa', 'Cách bú đúng tư thế'],
    },
    {
      'title': 'Tắm bé & Vệ sinh',
      'category': 'Tại nhà',
      'date': '08 Th4 | 14:30',
      'location': 'Lê Duẩn, Đà Nẵng',
      'color': const Color(0xFFA5D6A7),
      'caregiverName': 'Phạm Ngọc Anh',
      'caregiverRole': 'Điều dưỡng nhi khoa',
      'caregiverAvatar': 'assets/images/cavegiver (4).png',
      'status': 'upcoming',
      'initials': 'NA',
      'rating': 4.9,
      'reviewCount': 112,
      'bio': 'Điều dưỡng nhi khoa với 9 năm kinh nghiệm, chuyên theo dõi phát triển trẻ sơ sinh tại Thanh Khê.',
      'specialties': ['Kiểm tra sức khoẻ bé', 'Tắm bé & massage bé', 'Theo dõi cân nặng'],
    },
  ];

  final List<Map<String, dynamic>> _pastBookings = [
    {
      'title': 'Khám hậu sản',
      'category': 'Bệnh viện',
      'date': '28 Th3 | 10:00',
      'location': 'Lê Duẩn, Đà Nẵng',
      'color': const Color(0xFF90CAF9),
      'caregiverName': 'Nguyễn Thị Mai',
      'caregiverRole': 'Điều dưỡng sau sinh',
      'caregiverAvatar': 'assets/images/cavegiver (1).png',
      'status': 'completed',
      'initials': 'NM',
      'rating': 4.9,
      'reviewCount': 128,
      'bio': '7 năm kinh nghiệm chăm sóc mẹ và bé sau sinh tại Bệnh viện Phụ sản Nhi Đà Nẵng.',
      'specialties': ['Chăm sóc vết mổ', 'Hỗ trợ tắm bé', 'Tư vấn dinh dưỡng'],
    },
    {
      'title': 'Massage cho mẹ',
      'category': 'Phục hồi',
      'date': '25 Th3 | 08:30',
      'location': 'Lê Duẩn, Đà Nẵng',
      'color': const Color(0xFFFFAB91),
      'caregiverName': 'Lê Phương Thảo',
      'caregiverRole': 'Chuyên viên massage',
      'caregiverAvatar': 'assets/images/cavegiver (3).png',
      'status': 'completed',
      'initials': 'PT',
      'rating': 4.7,
      'reviewCount': 74,
      'bio': '5 năm kinh nghiệm massage phục hồi sau sinh và giảm eo chuyên sâu cho các mẹ tại Cẩm Lệ.',
      'specialties': ['Massage bụng giảm eo', 'Phục hồi cơ thể', 'Giảm đau vai gáy'],
    },
  ];
}




