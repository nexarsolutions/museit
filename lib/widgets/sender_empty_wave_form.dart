// --- Empty waveform when nothing recorded ---
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SenderEmptyWaveForm extends StatelessWidget {
  const SenderEmptyWaveForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      height: 100,
      child: Center(
        child: CustomPaint(
          size: Size(Get.width * 0.7, 2),
          painter: _StraightLinePainter(),
        ),
      ),
    );
  }
}

// --- Custom Painter for straight waveform line ---
class _StraightLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF8C7FAC), Color(0xFF7695CA)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
