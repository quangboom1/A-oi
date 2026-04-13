import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class DockNavBar extends StatelessWidget {
  final int currentIndex;
  final List<String> navLabels;
  final Function(int) onTap;

  const DockNavBar({
    super.key,
    required this.currentIndex,
    required this.navLabels,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavBarItem(0, 'assets/icons/home.svg', currentIndex, navLabels[0], onTap),
          _NavBarItem(1, 'assets/icons/care.svg', currentIndex, navLabels[1], onTap),
          _NavBarItem(2, 'assets/icons/baby.svg', currentIndex, navLabels[2], onTap),
          _NavBarItem(3, 'assets/icons/community.svg', currentIndex, navLabels[3], onTap),
          _NavBarItem(4, 'assets/icons/knowledge.svg', currentIndex, navLabels[4], onTap),
        ],

      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final int currentIndex;
  final String label;
  final Function(int) onTap;

  const _NavBarItem(this.index, this.iconPath, this.currentIndex, this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentIndex == index;

    return Tooltip(
      message: label,
      preferBelow: false,
      verticalOffset: 20,
      decoration: BoxDecoration(
        color: AppTheme.onSurface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isActive ? Colors.white : AppTheme.onSurface.withOpacity(0.4),
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}




