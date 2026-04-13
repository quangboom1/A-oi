import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
    required this.icon,
    required this.iconColor,
  });
}

class NotificationPopup extends StatelessWidget {
  const NotificationPopup({super.key});

  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Notifications',
      barrierColor: Colors.black.withOpacity(0.05),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const NotificationPopup();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuart,
          )),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifications = [
      NotificationItem(
        title: 'Nhắc nhở tiêm chủng',
        message: 'Bé đến lịch tiêm chủng định kỳ 6 tháng vào ngày mai.',
        time: '15 phút trước',
        icon: Icons.vaccines_rounded,
        iconColor: Colors.redAccent,
        isRead: false,
      ),
      NotificationItem(
        title: 'Caregiver mới',
        message: 'Có 3 chuyên gia mới vừa gia nhập khu vực của bạn.',
        time: '2 giờ trước',
        icon: Icons.person_add_rounded,
        iconColor: AppTheme.primary,
        isRead: false,
      ),
      NotificationItem(
        title: 'Mẹo nuôi con',
        message: 'Bạn đã đọc bài viết về dinh dưỡng cho bé chưa?',
        time: 'Hôm qua',
        icon: Icons.lightbulb_rounded,
        iconColor: Colors.amber,
        isRead: true,
      ),
      NotificationItem(
        title: 'Thanh toán thành công',
        message: 'Giao dịch cho gói Premium đã được xác nhận.',
        time: '2 ngày trước',
        icon: Icons.check_circle_rounded,
        iconColor: Colors.green,
        isRead: true,
      ),
    ];

    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).padding.top + 70,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Thông báo',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '2 mới',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close_rounded, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: notifications.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: AppTheme.outline.withOpacity(0.2),
                          indent: 24,
                          endIndent: 24,
                        ),
                        itemBuilder: (context, index) {
                          final item = notifications[index];
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                              color: item.isRead ? Colors.transparent : AppTheme.primary.withOpacity(0.02),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: item.iconColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(item.icon, color: item.iconColor, size: 22),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item.title,
                                                style: GoogleFonts.inter(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppTheme.onSurface,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              item.time,
                                              style: GoogleFonts.inter(
                                                fontSize: 11,
                                                color: AppTheme.onSurfaceVariant.withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item.message,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: AppTheme.onSurfaceVariant,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        border: Border(
                          top: BorderSide(color: AppTheme.outline.withOpacity(0.1)),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Xem tất cả thông báo',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}




