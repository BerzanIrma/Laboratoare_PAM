

import 'package:flutter/material.dart';

enum CategoryType { women, men, accessories, beauty }

class CategoryItem extends StatelessWidget {
  final String title;
  final CategoryType type;
  final bool selected;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.title,
    required this.type,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 67,
        child: Column(
          children: [
            _icon(),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                color: selected
                    ? const Color(0xFF555555)
                    : const Color(0xFFAAAAAE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inactiveCircle(Widget child) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF4F4F5),
      ),
      child: child,
    );
  }

  /// Cercul activ (Women în design) – generalizat pentru orice categorie.
  Widget _activeCircle(Widget icon) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF3A2D29), width: 1.5),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF3A2D29),
            ),
            child: icon,
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    final Color color = selected ? Colors.white : const Color(0xFFA7A7A9);

    Widget icon;
    switch (type) {
      case CategoryType.women:
        icon = Icon(Icons.female, size: 23, color: color);
        break;
      case CategoryType.men:
        icon = Icon(Icons.male, size: 22, color: color);
        break;
      case CategoryType.accessories:
        icon = Center(
          child: SizedBox(
            width: 27,
            height: 18,
            child: CustomPaint(painter: GlassesPainter(color: color)),
          ),
        );
        break;
      case CategoryType.beauty:
        icon = Icon(Icons.brush_outlined, size: 22, color: color);
        break;
    }

    return selected ? _activeCircle(icon) : _inactiveCircle(icon);
  }
}

// ============================================================
// GLASSES PAINTER
// ============================================================

class GlassesPainter extends CustomPainter {
  final Color color;

  const GlassesPainter({this.color = const Color(0xFFA3A3A5)});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double centerY = size.height * 0.62;

    RRect lens(double cx) => RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * cx, centerY),
        width: size.width * 0.40,
        height: size.height * 0.55,
      ),
      const Radius.circular(5),
    );

    canvas.drawRRect(lens(0.30), paint);
    canvas.drawRRect(lens(0.70), paint);

    canvas.drawLine(
      Offset(size.width * 0.47, centerY),
      Offset(size.width * 0.53, centerY),
      paint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.11, centerY - 3)
        ..lineTo(size.width * 0.02, centerY - 9)
        ..lineTo(size.width * 0.02, centerY - 12),
      paint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.89, centerY - 3)
        ..lineTo(size.width * 0.98, centerY - 9)
        ..lineTo(size.width * 0.98, centerY - 12),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GlassesPainter oldDelegate) =>
      oldDelegate.color != color;
}

