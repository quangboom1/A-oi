import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/shader_background.dart';
import 'create_post_screen.dart';
import '../widgets/feed_item.dart';

class CommunityScreen extends StatelessWidget {

  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            // 1. Header with Profile, Search, and Add
            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    _buildAvatar(),
                    const Spacer(),
                    _buildRoundIconButton(Icons.search_rounded),
                    const SizedBox(width: 12),
                    _buildRoundIconButton(Icons.add_rounded),
                  ],
                ),
              ),
            ),

            // 2. Create Post Section
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              sliver: SliverToBoxAdapter(
                child: _buildCreatePostButton(context),
              ),
            ),


            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // 3. Social Feed
            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 120),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  FeedItem(
                    username: 'Bác sĩ Nhi khoa',
                    time: 'Đăng bởi BS. Tuấn hôm qua lúc 11:30',
                    content: 'Lịch tiêm chủng mở rộng năm 2024 có một số thay đổi quan trọng giúp bảo vệ bé khỏi các chủng virus mới. Các ba mẹ hãy lưu ý lưu lại lịch này để bé được bảo vệ toàn diện nhất nhé! #tiemchung #suckhoebe',
                    likes: 2450,
                    comments: 423,
                    reposts: 220,
                    isVerified: true,
                  ),

                  const SizedBox(height: 24),
                  FeedItem(
                    username: 'Gia đình bé Tôm',
                    time: 'Đăng 1 giờ trước',
                    content: 'Hôm nay gia đình em làm lễ đầy tháng cho bé Tôm. Cảm ơn dịch vụ À Ơi đã chuẩn bị mâm cúng chu đáo và trang nghiêm quá ạ! #daythang #mamcung #aoi',
                    imageUrl: 'public/cung.png',
                    likes: 856,
                    comments: 120,
                    reposts: 15,
                  ),
                  const SizedBox(height: 24),
                  FeedItem(
                    username: 'Mẹ Bé Bơ',

                    time: 'Đăng 2 giờ trước',
                    content: 'Có mẹ nào gặp tình trạng bé gắt ngủ vào buổi tối không ạ? Bé nhà em 3 tháng tuổi, cứ đến 7h tối là khóc ngằn ngặt mặc dù đã ăn no và thay tã sạch sẽ. Cần lắm kinh nghiệm từ các mẹ thông thái!',
                    likes: 128,
                    comments: 56,
                    reposts: 4,
                  ),

                ]),
              ),
            ),
          ],
        ),
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
        image: const DecorationImage(
          image: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=Sarah'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRoundIconButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Icon(icon, color: AppTheme.onSurface, size: 24),
    );
  }

  Widget _buildCreatePostButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreatePostScreen()),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60), // Pill shape
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.white.withOpacity(0.6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.auto_awesome_rounded, color: AppTheme.primary, size: 22),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Bạn muốn hỏi hay chia sẻ điều gì?',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded, size: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


