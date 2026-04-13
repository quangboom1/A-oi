import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';

class EditMotherBabyScreen extends StatefulWidget {
  const EditMotherBabyScreen({super.key});

  @override
  State<EditMotherBabyScreen> createState() => _EditMotherBabyScreenState();
}

class _EditMotherBabyScreenState extends State<EditMotherBabyScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mother Controllers
  final _mNameController = TextEditingController(text: 'Nguyễn Thị Lan');
  final _mAgeController = TextEditingController(text: '28');
  final _mWeightController = TextEditingController(text: '54');
  final _mHeightController = TextEditingController(text: '162');
  final _mDoctorController = TextEditingController(text: 'BS. Minh Hương');
  String _mBloodType = 'A+';
  String _mBirthMethod = 'Sinh thường';

  // Baby Controllers
  final _bNameController = TextEditingController(text: 'Bé Bơ');
  final _bAgeController = TextEditingController(text: '6 tháng');
  final _bWeightController = TextEditingController(text: '7.5');
  final _bHeightController = TextEditingController(text: '68');
  String _bBloodType = 'O+';
  String _bGender = 'Nam';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mNameController.dispose();
    _mAgeController.dispose();
    _mWeightController.dispose();
    _mHeightController.dispose();
    _mDoctorController.dispose();
    _bNameController.dispose();
    _bAgeController.dispose();
    _bWeightController.dispose();
    _bHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 60,
      desktop: MediaQuery.of(context).size.width * 0.25,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ShaderBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
                child: Row(
                  children: [
                    _buildBackIcon(),
                    const SizedBox(width: 20),
                    Text(
                      'Chỉnh sửa thông tin',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: _buildCustomTabBar(),
              ),

              // Main Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMotherEditForm(horizontalPadding),
                    _buildBabyEditForm(horizontalPadding),
                  ],
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 32),
                child: _buildSaveButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: AnimatedBuilder(
        animation: _tabController.animation!,
        builder: (context, child) {
          // Calculate precise alignment from animation value (0.0 to 1.0)
          // Map 0.0 -> -1.0 (Left) and 1.0 -> 1.0 (Right)
          final double alignmentX = (_tabController.animation!.value * 2) - 1;
          
          return Stack(
            children: [
              // Sliding Background (Real-time)
              Align(
                alignment: Alignment(alignmentX, 0),
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Tab Buttons
              Row(
                children: [
                  _buildTabButton(0, 'Thông tin Mẹ'),
                  _buildTabButton(1, 'Thông tin Bé'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    // Determine active state based on animation value for smoother color transition
    final bool isActive = (_tabController.animation!.value - index).abs() < 0.5;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index, duration: const Duration(milliseconds: 350), curve: Curves.easeOutCubic);
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              color: isActive ? Colors.white : AppTheme.onSurfaceVariant.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMotherEditForm(double padding) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 24),
      child: Column(
        children: [
          _buildInfoItem(Icons.person_outline_rounded, 'Họ và tên', _mNameController, 'Nhập tên mẹ'),
          const SizedBox(height: 16),
          _buildInfoItem(Icons.cake_outlined, 'Tuổi', _mAgeController, 'Nhập số tuổi', keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInfoItem(Icons.monitor_weight_outlined, 'Cân nặng (kg)', _mWeightController, 'Kg', keyboardType: TextInputType.number)),
              const SizedBox(width: 16),
              Expanded(child: _buildInfoItem(Icons.height_rounded, 'Chiều cao (cm)', _mHeightController, 'Cm', keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 16),
          _buildSelectField('Nhóm máu', Icons.bloodtype_outlined, ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'], _mBloodType, (v) => setState(() => _mBloodType = v!)),
          const SizedBox(height: 16),
          _buildSelectField('Phương pháp sinh', Icons.medical_services_outlined, ['Sinh thường', 'Sinh mổ'], _mBirthMethod, (v) => setState(() => _mBirthMethod = v!)),
          const SizedBox(height: 16),
          _buildInfoItem(Icons.badge_outlined, 'Bác sĩ phụ trách', _mDoctorController, 'Tên bác sĩ'),
        ],
      ),
    );
  }

  Widget _buildBabyEditForm(double padding) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 24),
      child: Column(
        children: [
          _buildInfoItem(Icons.child_care_rounded, 'Tên bé / Biệt danh', _bNameController, 'Nhập tên bé'),
          const SizedBox(height: 16),
          _buildInfoItem(Icons.calendar_today_rounded, 'Tuổi của bé', _bAgeController, 'VD: 6 tháng'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInfoItem(Icons.monitor_weight_outlined, 'Cân nặng (kg)', _bWeightController, 'Kg', keyboardType: TextInputType.number)),
              const SizedBox(width: 16),
              Expanded(child: _buildInfoItem(Icons.straighten_rounded, 'Chiều dài (cm)', _bHeightController, 'Cm', keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildSelectField('Giới tính', Icons.transgender_rounded, ['Nam', 'Nữ'], _bGender, (v) => setState(() => _bGender = v!))),
              const SizedBox(width: 16),
              Expanded(child: _buildSelectField('Nhóm máu', Icons.bloodtype_outlined, ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'], _bBloodType, (v) => setState(() => _bBloodType = v!))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackIcon() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppTheme.onSurface),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, TextEditingController controller, String hint, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.onSurfaceVariant.withOpacity(0.6))),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: AppTheme.onSurface),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppTheme.primary, size: 20),
              hintText: hint,
              hintStyle: GoogleFonts.inter(color: AppTheme.onSurfaceVariant.withOpacity(0.3), fontWeight: FontWeight.w500),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectField(String label, IconData icon, List<String> options, String current, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.onSurfaceVariant.withOpacity(0.6))),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: current,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.onSurfaceVariant),
              items: options.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: AppTheme.onSurface)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Thông tin đã được cập nhật!'),
            backgroundColor: AppTheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(color: AppTheme.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Center(
          child: Text(
            'Lưu thay đổi',
            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.5),
          ),
        ),
      ),
    );
  }
}



