import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AppVideoPlayer extends StatefulWidget {
  final String assetPath;

  const AppVideoPlayer({super.key, required this.assetPath});

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _showControls = true;
  DateTime _lastInteraction = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _controller = VideoPlayerController.asset(widget.assetPath);
    
    try {
      await _controller.initialize();
      _controller.addListener(() {
        if (mounted) setState(() {});
        
        // Auto-hide controls after 3 seconds of inactivity
        if (_showControls && DateTime.now().difference(_lastInteraction).inSeconds > 3) {
          if (mounted) setState(() => _showControls = false);
        }
      });
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
        });
      }
    } catch (e) {
      debugPrint("Video Error: $e");
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _onInteraction() {
    setState(() {
      _showControls = true;
      _lastInteraction = DateTime.now();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.red, size: 32),
            const SizedBox(height: 12),
            const Text(
              'Không thể tải video',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Thiếu file: ${widget.assetPath}',
              style: TextStyle(color: Colors.red.withOpacity(0.6), fontSize: 10),
            ),
            TextButton(
              onPressed: _initPlayer,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(28),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: AppTheme.primary),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: GestureDetector(
        onTap: () {
          setState(() => _showControls = !_showControls);
          if (_showControls) _lastInteraction = DateTime.now();
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: VideoPlayer(_controller),
            ),
            
            // Custom Glass Controls
            if (_showControls)
              VideoControlOverlay(
                controller: _controller,
                onInteraction: _onInteraction,
                toggleFullscreen: () => _toggleFullscreen(context),
              ),
            
            // Big Play Button if not playing and controls hidden
            if (!_controller.value.isPlaying && !_showControls)
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _toggleFullscreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullscreenVideoPage(controller: _controller),
      ),
    );
  }
}

class VideoControlOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onInteraction;
  final VoidCallback toggleFullscreen;
  final bool isFullscreen;

  const VideoControlOverlay({
    super.key, 
    required this.controller,
    required this.onInteraction,
    required this.toggleFullscreen,
    this.isFullscreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: isFullscreen ? 40 : 12,
      left: isFullscreen ? 24 : 12,
      right: isFullscreen ? 24 : 12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  colors: VideoProgressColors(
                    playedColor: AppTheme.primary,
                    bufferedColor: Colors.white.withOpacity(0.2),
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _controlButton(
                      icon: controller.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      onTap: () {
                        onInteraction();
                        controller.value.isPlaying ? controller.pause() : controller.play();
                      },
                    ),
                    const SizedBox(width: 8),
                    _controlButton(
                      icon: Icons.replay_10_rounded,
                      onTap: () {
                        onInteraction();
                        controller.seekTo(controller.value.position - const Duration(seconds: 10));
                      },
                    ),
                    _controlButton(
                      icon: Icons.forward_10_rounded,
                      onTap: () {
                        onInteraction();
                        controller.seekTo(controller.value.position + const Duration(seconds: 10));
                      },
                    ),
                    const Spacer(),
                    Text(
                      "${_formatDuration(controller.value.position)} / ${_formatDuration(controller.value.duration)}",
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _controlButton(
                      icon: isFullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
                      onTap: toggleFullscreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _controlButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.transparent,
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return "${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
    }
    return "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}

class FullscreenVideoPage extends StatefulWidget {
  final VideoPlayerController controller;

  const FullscreenVideoPage({super.key, required this.controller});

  @override
  State<FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  bool _showControls = true;
  DateTime _lastInteraction = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    if (_showControls && DateTime.now().difference(_lastInteraction).inSeconds > 3) {
      if (mounted) setState(() => _showControls = false);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() => _showControls = !_showControls);
          if (_showControls) _lastInteraction = DateTime.now();
        },
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
            ),
            
            // Back Button
            if (_showControls)
              Positioned(
                top: 40,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

            // Same Premium Controls for Fullscreen
            if (_showControls)
              VideoControlOverlay(
                controller: widget.controller,
                isFullscreen: true,
                onInteraction: () => setState(() => _lastInteraction = DateTime.now()),
                toggleFullscreen: () => Navigator.pop(context),
              ),
          ],
        ),
      ),
    );
  }
}




