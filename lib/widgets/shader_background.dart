import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ShaderBackground extends StatefulWidget {
  final Widget child;
  final bool isDark;
  const ShaderBackground({super.key, required this.child, this.isDark = false});

  @override
  State<ShaderBackground> createState() => _ShaderBackgroundState();
}

class _ShaderBackgroundState extends State<ShaderBackground> with SingleTickerProviderStateMixin {
  ui.FragmentShader? _shader;
  late Ticker _ticker;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    _loadShader();
    _ticker = createTicker((elapsed) {
      if (!mounted) return;
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0;
      });
    });
  }

  Future<void> _loadShader() async {
    try {
      final program = await ui.FragmentProgram.fromAsset('assets/shaders/background.frag');
      setState(() {
        _shader = program.fragmentShader();
        _ticker.start();
      });
    } catch (e) {
      debugPrint("Error loading shader: \$e");
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_shader == null) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F9EC), Color(0xFFE8F1D6)],
          ),
        ),
        child: widget.child,
      );
    }
    return CustomPaint(
      painter: ShaderPainter(_shader!, _time, widget.isDark),
      child: widget.child,
    );
  }
}

class ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;
  final bool isDark;

  ShaderPainter(this.shader, this.time, this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    if (isDark) {
      // Darker, moodier colors for Night Mode
      // Color 1: Deep Navy/Purple (0.05, 0.05, 0.15)
      shader.setFloat(3, 0.05);
      shader.setFloat(4, 0.05);
      shader.setFloat(5, 0.15);

      // Color 2: Dark Slate (0.1, 0.1, 0.12)
      shader.setFloat(6, 0.1);
      shader.setFloat(7, 0.1);
      shader.setFloat(8, 0.12);

      // Color 3: Muted Indigo (0.08, 0.08, 0.2)
      shader.setFloat(9, 0.08);
      shader.setFloat(10, 0.08);
      shader.setFloat(11, 0.2);

      // Color 4: Deep Charcoal (0.02, 0.02, 0.05)
      shader.setFloat(12, 0.02);
      shader.setFloat(13, 0.02);
      shader.setFloat(14, 0.05);

      // Color 5: Dark Forest/Navy (0.03, 0.05, 0.08)
      shader.setFloat(15, 0.03);
      shader.setFloat(16, 0.05);
      shader.setFloat(17, 0.08);
    } else {
      // Color 1: c50 (0.961, 0.976, 0.925)
      shader.setFloat(3, 0.961);
      shader.setFloat(4, 0.976);
      shader.setFloat(5, 0.925);

      // Color 2: c100 (0.910, 0.945, 0.839)
      shader.setFloat(6, 0.910);
      shader.setFloat(7, 0.945);
      shader.setFloat(8, 0.839);

      // Color 3: c200 (0.824, 0.894, 0.698)
      shader.setFloat(9, 0.824);
      shader.setFloat(10, 0.894);
      shader.setFloat(11, 0.698);

      // Color 4: c300 (0.675, 0.804, 0.459)
      shader.setFloat(12, 0.675);
      shader.setFloat(13, 0.804);
      shader.setFloat(14, 0.459);

      // Color 5: White (1.0, 1.0, 1.0)
      shader.setFloat(15, 1.0);
      shader.setFloat(16, 1.0);
      shader.setFloat(17, 1.0);
    }

    shader.setFloat(18, 0.07); // noise strength
    shader.setFloat(19, 0.0); // mode 0 for mesh

    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}



