import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/shader_background.dart';
import 'profile_screen.dart';
import '../widgets/feed_item.dart';

class PostDetailScreen extends StatelessWidget {

  final String username;
  final String time;
  final String content;
  final String? imageUrl;
  final bool isVerified;
  final int likes;
  final int comments;

  const PostDetailScreen({
    super.key,
    required this.username,
    required this.time,
    required this.content,
    this.imageUrl,
    this.isVerified = false,
    this.likes = 0,
    this.comments = 0,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.value(
      context,
      mobile: 24,
      tablet: 40,
      desktop: Responsive.getWidth(context) * 0.1,
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
                    _buildRoundIconButton(Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
                    const SizedBox(width: 16),
                    Text(
                      'Bài viết',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Post Content
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      sliver: SliverToBoxAdapter(
                        child: FeedItem(
                          username: username,
                          time: time,
                          content: content,
                          imageUrl: imageUrl,
                          likes: likes,
                          comments: comments,
                          isVerified: isVerified,
                          isDetailView: true,
                        ),
                      ),
                    ),


                    const SliverToBoxAdapter(child: SizedBox(height: 32)),

                    // Comments Section Header
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Bình luận ($comments)',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.onSurface,
                          ),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 16)),

                    // Comments List
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 100),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          _buildCommentItem(
                            context: context,
                            username: 'Minh Anh',
                            time: '10 phút trước',
                            text: 'Bài viết rất hữu ích ạ! Cảm ơn bác đã chia sẻ.',
                            likes: 5,
                          ),
                          _buildCommentItem(
                            context: context,
                            username: 'Hoàng Nam',
                            time: '2 giờ trước',
                            text: 'Em cũng đang gặp tình trạng tương tự. Rất mong có thêm nhiều bài viết như này.',
                            likes: 12,
                          ),

                        ]),
                      ),
                    ),
                  ],
                ),
              ),

              // Sticky Input Bar
              _buildCommentInputBar(context, horizontalPadding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Icon(icon, color: AppTheme.onSurface, size: 18),
      ),
    );
  }


  Widget _buildCommentItem({
    required BuildContext context,
    required String username,
    required String time,
    required String text,
    required int likes,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  username: username,
                ),
              ),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=$username'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              username: username,
                            ),
                          ),
                        ),
                        child: Text(
                          username,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        text,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppTheme.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      time,
                      style: GoogleFonts.inter(fontSize: 11, color: AppTheme.onSurfaceVariant.withOpacity(0.6)),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Thích',
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.onSurfaceVariant),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Phản hồi',
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputBar(BuildContext context, double horizontalPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 12, horizontalPadding, 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black.withOpacity(0.1)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Viết bình luận...',
                  hintStyle: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send_rounded, size: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
