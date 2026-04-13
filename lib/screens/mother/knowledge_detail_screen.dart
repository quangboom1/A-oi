import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/shader_background.dart';
import '../../widgets/video_player_widget.dart';

class KnowledgeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const KnowledgeDetailScreen({super.key, required this.article});

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
        child: Stack(
          children: [
            // Main Content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Hero Image Header
                SliverAppBar(
                  expandedHeight: 400,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        article['image'].startsWith('http')
                            ? Image.network(article['image'], fit: BoxFit.cover)
                            : Image.asset(article['image'], fit: BoxFit.cover),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. Article Content
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(horizontalPadding, 32, horizontalPadding, 120),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category & Time
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      article['category'],
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(Icons.access_time_rounded, size: 14, color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
                                  const SizedBox(width: 6),
                                  Text(
                                    article['time'],
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Title
                              Text(
                                article['title'],
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.onSurface,
                                  height: 1.2,
                                  letterSpacing: -0.5,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Author / Meta
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=Expert'),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BS. Nguyễn Hải Yến',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: AppTheme.onSurface,
                                        ),
                                      ),
                                      Text(
                                        'Chuyên gia Nhi khoa · 29/03/2026',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),

                              // Separator
                              Container(
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),

                              const SizedBox(height: 32),

                              // Video Content (Proper aspect ratio)
                              if (article['isVideo'] == true) ...[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: AppVideoPlayer(assetPath: article['videoUrl']),
                                ),
                                const SizedBox(height: 32),
                              ],

                              // Content Text
                              Text(
                                article['content'] ?? 'Nội dung bài viết đang được cập nhật...',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: AppTheme.onSurface.withOpacity(0.85),
                                  height: 1.8,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Quote / Tip Box
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.lightbulb_outline_rounded, color: AppTheme.primary),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Lời khuyên từ chuyên gia',
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppTheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Mỗi em bé là một cá thể duy nhất. Hãy luôn lắng nghe và quan sát phản ứng của bé để điều chỉnh cách chăm sóc phù hợp nhất mẹ nhé!',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: AppTheme.onSurfaceVariant,
                                        fontStyle: FontStyle.italic,
                                        height: 1.5,
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
                ),
              ],
            ),

            // Top Buttons (Back, Share)
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFloatingIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      _buildFloatingIconButton(icon: Icons.ios_share_rounded, onTap: () {}),
                      const SizedBox(width: 12),
                      _buildFloatingIconButton(icon: Icons.bookmark_outline_rounded, onTap: () {}),
                    ],
                  ),
                ],
              ),
            ),
            
            // Bottom Action Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomActionBar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Icon(icon, color: AppTheme.onSurface, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.9),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.forum_outlined, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Thảo luận về bài viết',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
            ),
            child: const Icon(Icons.favorite_border_rounded, color: AppTheme.primary, size: 24),
          ),
        ],
      ),
    );
  }
}




