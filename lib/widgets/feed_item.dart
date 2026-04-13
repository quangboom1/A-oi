import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../screens/mother/profile_screen.dart';
import '../screens/mother/post_detail_screen.dart';

class FeedItem extends StatefulWidget {
  final String username;
  final String time;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int? reposts;
  final bool isVerified;
  final bool isDetailView;

  const FeedItem({
    super.key,
    required this.username,
    required this.time,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    this.reposts,
    this.isVerified = false,
    this.isDetailView = false,
  });

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  bool _isReposted = false;
  bool _isBookmarked = false;
  late AnimationController _likeController;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.2,
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likeController.forward().then((value) => _likeController.reverse());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!widget.isDetailView) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              username: widget.username,
                              isVerified: widget.isVerified,
                            ),
                          ),
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(widget.username)}'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!widget.isDetailView) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                    username: widget.username,
                                    isVerified: widget.isVerified,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                widget.username,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.onSurface,
                                ),
                              ),
                              if (widget.isVerified) ...[
                                const SizedBox(width: 4),
                                Icon(Icons.verified_rounded, size: 16, color: AppTheme.primary),
                              ],
                            ],
                          ),
                        ),
                        Text(
                          widget.time,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_horiz_rounded, color: AppTheme.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.content,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppTheme.onSurface,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.imageUrl != null) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: widget.imageUrl!.startsWith('http')
                      ? Image.network(
                          widget.imageUrl!,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          widget.imageUrl!,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  ScaleTransition(
                    scale: _likeController,
                    child: _buildFeedAction(
                      icon: _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      label: _formatNumber(widget.likes + (_isLiked ? 1 : 0)),
                      color: _isLiked ? Colors.pink : null,
                      onTap: _toggleLike,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildFeedAction(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: _formatNumber(widget.comments),
                    onTap: () {
                      if (!widget.isDetailView) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(
                              username: widget.username,
                              time: widget.time,
                              content: widget.content,
                              imageUrl: widget.imageUrl,
                              isVerified: widget.isVerified,
                              likes: widget.likes,
                              comments: widget.comments,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  if (widget.reposts != null)
                    _buildFeedAction(
                      icon: Icons.repeat_rounded,
                      label: _formatNumber(widget.reposts! + (_isReposted ? 1 : 0)),
                      color: _isReposted ? AppTheme.primary : null,
                      onTap: () => setState(() => _isReposted = !_isReposted),
                    ),
                  const Spacer(),
                  _buildFeedAction(
                    icon: _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    color: _isBookmarked ? Colors.orange : null,
                    onTap: () => setState(() => _isBookmarked = !_isBookmarked),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedAction({
    required IconData icon,
    String? label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: color?.withOpacity(0.1) ?? Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color?.withOpacity(0.3) ?? Colors.white.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color ?? AppTheme.onSurface),
            if (label != null) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color ?? AppTheme.onSurface,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}



