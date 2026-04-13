import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import 'caregiver_detail_screen.dart';

// ─────────────────────────────────────────────
//  Data Models
// ─────────────────────────────────────────────

class _Caregiver {
  final String name;
  final String role;
  final String initials;
  final double rating;
  final int reviewCount;
  final Color accent;
  final String bio;
  final List<String> specialties;
  final String image;

  const _Caregiver({
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
}

class _ServiceOption {
  final String title;
  final String description;
  final String price;
  final String duration;
  final IconData icon;
  final Color accent;

  const _ServiceOption({
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.icon,
    required this.accent,
  });
}

// ─────────────────────────────────────────────
//  Mock Data
// ─────────────────────────────────────────────

const List<_Caregiver> _caregivers = [
  _Caregiver(
    name: 'Nguyễn Thị Mai',
    role: 'Điều dưỡng sau sinh',
    initials: 'NM',
    rating: 4.9,
    reviewCount: 128,
    accent: Color(0xFF90CAF9),
    bio: '7 năm kinh nghiệm chăm sóc mẹ và bé sau sinh tại Lê Duẩn, Đà Nẵng.',
    specialties: ['Chăm sóc vết mổ', 'Hỗ trợ tắm bé', 'Tư vấn dinh dưỡng'],
    image: 'assets/images/cavegiver (1).png',
  ),
  _Caregiver(
    name: 'Trần Thu Hương',
    role: 'Chuyên gia sữa mẹ',
    initials: 'TH',
    rating: 4.8,
    reviewCount: 95,
    accent: Color(0xFFF48FB1),
    bio: 'Chuyên gia tư vấn nuôi con bằng sữa mẹ với chứng chỉ quốc tế IBCLC hiện đang công tác tại Lê Duẩn, Đà Nẵng.',
    specialties: ['Thông tắc tia sữa', 'Tư vấn lên sữa', 'Cách bú đúng tư thế'],
    image: 'assets/images/cavegiver (2).png',
  ),
  _Caregiver(
    name: 'Lê Phương Thảo',
    role: 'Chuyên viên massage',
    initials: 'PT',
    rating: 4.7,
    reviewCount: 74,
    accent: Color(0xFFFFAB91),
    bio: '5 năm kinh nghiệm massage phục hồi sau sinh và giảm eo chuyên sâu cho các mẹ tại Lê Duẩn, Đà Nẵng.',
    specialties: ['Massage bụng giảm eo', 'Phục hồi cơ thể', 'Giảm đau vai gáy'],
    image: 'assets/images/cavegiver (3).png',
  ),
  _Caregiver(
    name: 'Phạm Ngọc Anh',
    role: 'Điều dưỡng nhi khoa',
    initials: 'NA',
    rating: 4.9,
    reviewCount: 112,
    accent: Color(0xFFA5D6A7),
    bio: 'Điều dưỡng nhi khoa với 9 năm kinh nghiệm, chuyên theo dõi phát triển trẻ sơ sinh tại Lê Duẩn, Đà Nẵng.',
    specialties: ['Kiểm tra sức khoẻ bé', 'Tắm bé & massage bé', 'Theo dõi cân nặng'],
    image: 'assets/images/cavegiver (4).png',
  ),
  _Caregiver(
    name: 'Hoàng Lan Chi',
    role: 'Chuyên gia giấc ngủ',
    initials: 'LC',
    rating: 4.6,
    reviewCount: 61,
    accent: Color(0xFFCE93D8),
    bio: 'Tư vấn giấc ngủ cho trẻ sơ sinh, giúp bé ngủ xuyên đêm từ tuần thứ 6, chuyên gia hàng đầu tại Lê Duẩn, Đà Nẵng.',
    specialties: ['Lịch ngủ sinh học', 'Giảm quấy khóc', 'Phương pháp ru ngủ'],
    image: 'assets/images/cavegiver (5).png',
  ),
];

const List<_ServiceOption> _services = [
  _ServiceOption(
    title: 'Tắm bé & Vệ sinh',
    description: 'Tắm bé theo chuẩn y khoa, vệ sinh rốn và chăm sóc da bé sơ sinh.',
    price: '350.000đ',
    duration: '60 phút',
    icon: Icons.water_drop_rounded,
    accent: Color(0xFF90CAF9),
  ),
  _ServiceOption(
    title: 'Massage cho mẹ',
    description: 'Massage phục hồi toàn thân, giảm đau lưng và phục hồi vóc dáng sau sinh.',
    price: '450.000đ',
    duration: '90 phút',
    icon: Icons.self_improvement_rounded,
    accent: Color(0xFFFFAB91),
  ),
  _ServiceOption(
    title: 'Tư vấn sữa mẹ',
    description: 'Hỗ trợ thông tắc tia sữa, hướng dẫn kỹ thuật bú và kích sữa về.',
    price: '300.000đ',
    duration: '45 phút',
    icon: Icons.favorite_rounded,
    accent: Color(0xFFF48FB1),
  ),
  _ServiceOption(
    title: 'Kiểm tra sức khoẻ bé',
    description: 'Theo dõi cân nặng, chiều cao, phản xạ và sự phát triển của bé.',
    price: '280.000đ',
    duration: '30 phút',
    icon: Icons.monitor_heart_rounded,
    accent: Color(0xFFA5D6A7),
  ),
];

const List<String> _timeSlots = [
  '07:00', '08:00', '09:00',
  '10:00', '11:00', 
  '13:00', '14:00', '15:00',
  '16:00', '17:00', '18:00',
  '19:00', 
];

// ─────────────────────────────────────────────
//  Screen
// ─────────────────────────────────────────────

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  // State
  int _selectedCaregiverIndex = 0;
  int _selectedServiceIndex = 0;
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _showConfirm = false;

  late final AnimationController _confirmAnim;
  late final Animation<double> _confirmFade;

  @override
  void initState() {
    super.initState();
    _confirmAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _confirmFade = CurvedAnimation(
      parent: _confirmAnim,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    _addressController.dispose();
    _confirmAnim.dispose();
    super.dispose();
  }

  // ── helpers

  String _weekdayLabel(DateTime d) {
    const labels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    return labels[d.weekday - 1];
  }

  bool get _canBook =>
      _selectedTime != null && _selectedCaregiverIndex >= 0;

  void _onBook() {
    if (!_canBook) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng chọn giờ để đặt lịch.',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppTheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
      );
      return;
    }
    setState(() => _showConfirm = true);
    _confirmAnim.forward();
  }

  void _closeConfirm() {
    _confirmAnim.reverse().then((_) {
      if (mounted) setState(() => _showConfirm = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double hPad = Responsive.value(
      context,
      mobile: 24.0,
      tablet: 40.0,
      desktop: Responsive.getWidth(context) * 0.15,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: SafeArea(
          child: Stack(
            children: [
              // ── Main scroll content
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Header
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(hPad, 24, hPad, 0),
                    sliver: SliverToBoxAdapter(
                      child: _buildHeader(context),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 28)),

                  const SliverToBoxAdapter(child: SizedBox(height: 28)),

                  // 2. Caregiver List
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildSectionTitle('Chọn người chăm sóc'),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  SliverToBoxAdapter(
                    child: _buildCaregiverPicker(hPad),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 12)),

                  // Caregiver detail card
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildCaregiverDetailCard(),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 28)),

                  // 3. Date Picker
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildSectionTitle('Chọn ngày'),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  SliverToBoxAdapter(
                    child: _buildDatePicker(hPad),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 28)),

                  // 4. Time Picker
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildSectionTitle('Chọn giờ'),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildTimeGrid(),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 28)),

                  // 5. Booking Summary
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildSectionTitle('Tóm tắt đặt lịch'),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildSummaryCard(),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 20)),

                  // 6. Address
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildAddressField(),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 20)),

                  // 7. Note
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    sliver: SliverToBoxAdapter(
                      child: _buildNoteField(),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 28)),

                  // 8. Book Button
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 32),
                    sliver: SliverToBoxAdapter(
                      child: _buildBookButton(),
                    ),
                  ),

                  // bottom nav spacing
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              ),

              // ── Confirm overlay
              if (_showConfirm)
                FadeTransition(
                  opacity: _confirmFade,
                  child: _buildConfirmOverlay(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Section Header
  // ─────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _glassIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.pop(context),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đặt lịch chăm sóc',
                style: GoogleFonts.inter(
                  fontSize: Responsive.value(context, mobile: 26.0, tablet: 32.0),
                  fontWeight: FontWeight.w900,
                  color: AppTheme.onSurface,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Chăm sóc tận tâm, yêu thương trọn vẹn',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppTheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _glassIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppTheme.onSurface),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppTheme.onSurface,
        letterSpacing: -0.3,
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  2. Caregiver Picker (horizontal avatar row)
  // ─────────────────────────────────────────────

  Widget _buildCaregiverPicker(double hPad) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: hPad),
        itemCount: _caregivers.length,
        itemBuilder: (ctx, i) {
          final cg = _caregivers[i];
          final bool selected = _selectedCaregiverIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedCaregiverIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cg.accent.withOpacity(0.3),
                      border: Border.all(
                        color: selected ? cg.accent : Colors.white.withOpacity(0.6),
                        width: selected ? 3 : 1.5,
                      ),
                      boxShadow: [
                        if (selected)
                          BoxShadow(
                            color: cg.accent.withOpacity(0.4),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        cg.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 68,
                    child: Text(
                      cg.name.split(' ').last,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                        color: selected ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCaregiverDetailCard() {
    final cg = _caregivers[_selectedCaregiverIndex];
    final heroTag = 'caregiver_avatar_${cg.name}';
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: GestureDetector(
        key: ValueKey(_selectedCaregiverIndex),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 450),
              reverseTransitionDuration: const Duration(milliseconds: 350),
              pageBuilder: (_, __, ___) => CaregiverDetailScreen(
                name: cg.name,
                role: cg.role,
                initials: cg.initials,
                rating: cg.rating,
                reviewCount: cg.reviewCount,
                accent: cg.accent,
                bio: cg.bio,
                specialties: cg.specialties,
                image: cg.image,
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
        child: _glassCard(
          accentColor: cg.accent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Hero avatar
                  Hero(
                    tag: heroTag,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cg.accent.withOpacity(0.25),
                          border: Border.all(
                              color: cg.accent.withOpacity(0.4), width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            cg.image,
                            fit: BoxFit.cover,
                          ),
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
                          cg.name,
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          cg.role,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Rating badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD54F).withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFFFFD54F).withOpacity(0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 14, color: Color(0xFFFF8F00)),
                        const SizedBox(width: 4),
                        Text(
                          cg.rating.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          ' (${cg.reviewCount})',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Tap hint
              Row(
                children: [
                  Icon(Icons.touch_app_rounded,
                      size: 14,
                      color: cg.accent.withOpacity(0.7)),
                  const SizedBox(width: 6),
                  Text(
                    'Nhấn để xem hồ sơ chi tiết',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                cg.bio,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppTheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: cg.specialties.map((s) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: cg.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: cg.accent.withOpacity(0.3), width: 1),
                    ),
                    child: Text(
                      s,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  3. Date Picker
  // ─────────────────────────────────────────────

  Widget _buildDatePicker(double hPad) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 90)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppTheme.primary,
                  onPrimary: Colors.white,
                  onSurface: AppTheme.onSurface,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: hPad),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.55),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.7), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.calendar_month_rounded, color: AppTheme.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ngày chăm sóc',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_weekdayLabel(_selectedDate)}, ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit_calendar_rounded, color: AppTheme.primary, size: 22),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  4. Time Grid
  // ─────────────────────────────────────────────

  Widget _buildTimeGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.7), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.access_time_rounded, color: AppTheme.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Khung giờ khả dụng',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 14,
            ),
            itemCount: _timeSlots.length,
            itemBuilder: (context, i) {
              return _timeChip(_timeSlots[i]);
            },
          ),
        ],
      ),
    );
  }

  Widget _timeChip(String time) {
    final bool selected = _selectedTime == time;
    return GestureDetector(
      onTap: () => setState(() => _selectedTime = time),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primary : Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: selected ? AppTheme.primary : Colors.white.withOpacity(0.7),
            width: 1.5,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Center(
          child: Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: selected ? Colors.white : AppTheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  5. Summary Card
  // ─────────────────────────────────────────────

  Widget _buildSummaryCard() {
    final cg = _caregivers[_selectedCaregiverIndex];
    final svc = _services[_selectedServiceIndex];
    final d = _selectedDate;
    final timeStr = _selectedTime ?? '—';
    final weekLabel = _weekdayLabel(d);

    return _glassCard(
      accentColor: const Color(0xFFF4E7C6),
      child: Column(
        children: [
          _summaryRow(
            icon: Icons.spa_rounded,
            label: 'Dịch vụ',
            value: svc.title,
            accent: svc.accent,
          ),
          _divider(),
          _summaryRow(
            icon: Icons.person_rounded,
            label: 'Người chăm sóc',
            value: cg.name,
            accent: cg.accent,
          ),
          _divider(),
          _summaryRow(
            icon: Icons.calendar_today_rounded,
            label: 'Ngày',
            value: '$weekLabel, ${d.day}/${d.month}/${d.year}',
            accent: AppTheme.primary,
          ),
          _divider(),
          _summaryRow(
            icon: Icons.access_time_rounded,
            label: 'Giờ',
            value: timeStr,
            accent: AppTheme.primary,
          ),
          _divider(),
          _summaryRow(
            icon: Icons.timer_outlined,
            label: 'Thời lượng',
            value: svc.duration,
            accent: const Color(0xFF90CAF9),
          ),
          _divider(),
          _summaryRow(
            icon: Icons.payments_rounded,
            label: 'Chi phí',
            value: svc.price,
            accent: const Color(0xFFFFAB91),
            isHighlight: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.7), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Nhập địa điểm chăm sóc',
                hintStyle: GoogleFonts.inter(
                  color: AppTheme.onSurfaceVariant.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                labelText: 'Địa điểm',
                labelStyle: GoogleFonts.inter(
                  color: AppTheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                prefixIcon: Icon(Icons.location_on_rounded, color: AppTheme.primary, size: 20),
                prefixIconConstraints: const BoxConstraints(minWidth: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoteField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.7), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'VD: Bé đang bị hăm tã, mẹ cần massage vai gáy nhiều hơn...',
                hintStyle: GoogleFonts.inter(
                  color: AppTheme.onSurfaceVariant.withOpacity(0.5),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                labelText: 'Ghi chú thêm (Không bắt buộc)',
                labelStyle: GoogleFonts.inter(
                  color: AppTheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 14, right: 8),
                  child: Icon(Icons.notes_rounded,
                      color: AppTheme.primary, size: 20),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _summaryRow({
    required IconData icon,
    required String label,
    required String value,
    required Color accent,
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 16, color: Colors.black87),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppTheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: isHighlight ? 16 : 14,
              fontWeight: isHighlight ? FontWeight.w900 : FontWeight.w700,
              color: isHighlight ? AppTheme.primary : AppTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Divider(
        height: 1,
        color: Colors.black12,
      );


  // ─────────────────────────────────────────────
  //  7. Book Button
  // ─────────────────────────────────────────────

  Widget _buildBookButton() {
    return GestureDetector(
      onTap: _onBook,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.4),
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
                    AppTheme.primary,
                    AppTheme.primaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(60),
                border:
                    Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline_rounded,
                      color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Xác nhận đặt lịch',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Confirm Overlay
  // ─────────────────────────────────────────────

  Widget _buildConfirmOverlay() {
    final cg = _caregivers[_selectedCaregiverIndex];
    final svc = _services[_selectedServiceIndex];
    final d = _selectedDate;
    final timeStr = _selectedTime ?? '';

    return GestureDetector(
      onTap: _closeConfirm,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(44),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(44),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.8), width: 1.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Top Accent Circle (Minimalist Success Indicator)
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primary.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Yêu cầu của bạn đã được gửi',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.onSurface,
                              height: 1.2,
                              letterSpacing: -0.8,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Chuyên viên À Ơi sẽ gọi lại xác nhận trong ít phút nữa.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          // Receipt Style Details
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: Colors.black.withOpacity(0.04)),
                            ),
                            child: Column(
                              children: [
                                _detailItem('Dịch vụ', svc.title),
                                const SizedBox(height: 16),
                                _detailItem('Nhân sự', cg.name),
                                const SizedBox(height: 16),
                                _detailItem('Thời gian', '${_weekdayLabel(d)}, $timeStr'),
                                const SizedBox(height: 16),
                                const Divider(height: 1),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tổng phí',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.onSurfaceVariant),
                                    ),
                                    Text(
                                      svc.price,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: AppTheme.primary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          // Primary Action Button
                          GestureDetector(
                            onTap: () {
                              _closeConfirm();
                              
                              // Create a top-floating success toast
                              final overlay = Overlay.of(context);
                              OverlayEntry? entry;
                              
                              entry = OverlayEntry(
                                builder: (overlayContext) => Positioned(
                                  top: MediaQuery.of(overlayContext).padding.top + 16,
                                  left: 20,
                                  right: 20,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: TweenAnimationBuilder<double>(
                                      tween: Tween(begin: -100.0, end: 0.0),
                                      duration: const Duration(milliseconds: 600),
                                      curve: Curves.easeOutBack,
                                      builder: (context, offset, child) => 
                                        Transform.translate(offset: Offset(0, offset), child: child),
                                      child: Container(
                                        padding: const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primary,
                                          borderRadius: BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppTheme.primary.withOpacity(0.4),
                                              blurRadius: 25,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.celebration_rounded, color: Colors.white, size: 26),
                                            const SizedBox(width: 14),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Tuyệt vời! Đã ghi nhận lịch hẹn.',
                                                    style: GoogleFonts.inter(
                                                      fontWeight: FontWeight.w900,
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                  Text(
                                                    'À Ơi sẽ gọi xác nhận sớm nhất có thể.',
                                                    style: GoogleFonts.inter(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white.withOpacity(0.9),
                                                      fontSize: 12,
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
                                ),
                              );

                              overlay.insert(entry);
                              Future.delayed(const Duration(seconds: 4), () {
                                entry?.remove();
                              });

                              // Navigate back to Home
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Quay về trang chủ',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: _closeConfirm,
                            child: Text(
                              'Đóng',
                              style: GoogleFonts.inter(
                                color: AppTheme.onSurfaceVariant,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppTheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
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

  // ─────────────────────────────────────────────
  //  Shared glass card widget
  // ─────────────────────────────────────────────

  Widget _glassCard({
    Key? key,
    required Widget child,
    required Color accentColor,
  }) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.25),
                ],
              ),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                  color: Colors.white.withOpacity(0.6), width: 1.5),
            ),
            child: Stack(
              children: [
                // Accent blob
                Positioned(
                  top: -60,
                  right: -60,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




