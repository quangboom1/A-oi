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
            colors: [Color(0xFFF7FBF9), Color(0xFFF0F5F2)],
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
      // Original Organic Cocoon colors
      // Color 1: 0.631, 0.784, 0.651
      shader.setFloat(3, 0.631);
      shader.setFloat(4, 0.784);
      shader.setFloat(5, 0.651);

      // Color 2: 0.957, 0.906, 0.839
      shader.setFloat(6, 0.957);
      shader.setFloat(7, 0.906);
      shader.setFloat(8, 0.839);

      // Color 3: 0.812, 0.890, 0.820
      shader.setFloat(9, 0.812);
      shader.setFloat(10, 0.890);
      shader.setFloat(11, 0.820);

      // Color 4: 0.949, 0.953, 0.804
      shader.setFloat(12, 0.949);
      shader.setFloat(13, 0.953);
      shader.setFloat(14, 0.804);

      // Color 5: 0.906, 0.945, 0.910
      shader.setFloat(15, 0.906);
      shader.setFloat(16, 0.945);
      shader.setFloat(17, 0.910);
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
