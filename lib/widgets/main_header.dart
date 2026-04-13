import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../screens/mother/account_info_screen.dart';
import 'notification_popup.dart';

class MainHeader extends StatelessWidget {
  final double horizontalPadding;

  const MainHeader({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final Color darkText = AppTheme.onSurface;
    final Color greyText = AppTheme.onSurfaceVariant;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 0),
      child: Row(
        children: [
          // Image.asset(
          //   'assets/images/logo_no_bg.png',
          //   width: 32,
          //   height: 32,
          //   fit: BoxFit.contain,
          // ),
          // const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountInfoScreen()),
              );
            },
            child: _buildAvatar(),
          ),
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
                  'T.Việt',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => NotificationPopup.show(context),
            child: _buildNotificationBell(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final String seed = Uri.encodeComponent('T.Việt');
    return Container(
      width: 45,
      height: 45,
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
      ),
      child: ClipOval(
        child: Image.network(
          'https://api.dicebear.com/7.x/avataaars/png?seed=$seed',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationBell() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
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
          child: const Icon(Icons.notifications_none_rounded, color: Colors.black87, size: 22),
        ),
        Positioned(
          right: 2,
          top: 2,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}




