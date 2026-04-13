import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum UserRole { mother, caregiver }

/// Call this to show the role selection popup.
/// Returns the selected [UserRole], or null if dismissed.
Future<UserRole?> showRoleSelectionPopup(BuildContext context) {
  return showGeneralDialog<UserRole>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (_, __, ___) => const _RoleSelectionDialog(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curve,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.88, end: 1.0).animate(curve),
          child: child,
        ),
      );
    },
  );
}

class _RoleSelectionDialog extends StatefulWidget {
  const _RoleSelectionDialog();

  @override
  State<_RoleSelectionDialog> createState() => _RoleSelectionDialogState();
}

class _RoleSelectionDialogState extends State<_RoleSelectionDialog> {
  UserRole? _selected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred backdrop
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
        ),

        // Dialog card
        Center(
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        'Bạn là ai?',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chọn vai trò của bạn để cá nhân hóa trải nghiệm',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.65),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Role Selection (Vertical list of horizontal bars)
                      Column(
                        children: [
                          _RoleCard(
                            emoji: '🤱',
                            title: 'Mẹ',
                            subtitle: 'Theo dõi sức khỏe và hành trình của mẹ',
                            isSelected: _selected == UserRole.mother,
                            onTap: () => setState(() => _selected = UserRole.mother),
                          ),
                          const SizedBox(height: 12),
                          _RoleCard(
                            emoji: '🩺',
                            title: 'Người chăm sóc',
                            subtitle: 'Hỗ trợ và chăm sóc mẹ và bé',
                            isSelected: _selected == UserRole.caregiver,
                            onTap: () => setState(() => _selected = UserRole.caregiver),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Action Buttons
                      Row(
                        children: [
                          // Cancel
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(null),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Huỷ',
                                    style: GoogleFonts.inter(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Confirm Button
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: _selected == null
                                  ? null
                                  : () => Navigator.of(context).pop(_selected),
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: _selected == null ? 0.45 : 1.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.25),
                                        borderRadius: BorderRadius.circular(60),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.4),
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Tiếp tục',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.30)
                    : Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isSelected
                      ? Colors.white.withOpacity(0.70)
                      : Colors.white.withOpacity(0.20),
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  // Emoji in bubble
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(isSelected ? 0.28 : 0.12),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(emoji, style: const TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.1,
                          ),
                        ),
                        if (subtitle.isNotEmpty)
                          Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.55),
                              height: 1.4,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Selection indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? Colors.white.withOpacity(0.9)
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.white.withOpacity(isSelected ? 0.9 : 0.35),
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 12, color: Colors.black87)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




