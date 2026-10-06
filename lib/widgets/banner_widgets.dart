

import 'package:flutter/material.dart';

// ============================================================
// AUTUMN COLLECTION (slider)
// ============================================================

class AutumnBanner extends StatelessWidget {
  const AutumnBanner({super.key});

  Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: active ? 7 : 5,
      height: active ? 7 : 5,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.65),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31),
      child: SizedBox(
        height: 163,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/1.jpg', fit: BoxFit.cover),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 18),
                child: const SizedBox(
                  width: 132,
                  child: Text(
                    'Autumn\nCollection\n2021',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 9,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_dot(true), _dot(false), _dot(false)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// NEW COLLECTION (full width)
// ============================================================

class NewCollectionBanner extends StatelessWidget {
  const NewCollectionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double bannerWidth = constraints.maxWidth;
        final double bannerHeight = bannerWidth / 2.38;

        final double outerCircle = bannerHeight * 0.84;
        final double innerCircle = bannerHeight * 0.65;

        return Container(
          width: double.infinity,
          height: bannerHeight,
          decoration: const BoxDecoration(color: Color(0xFFF8F8FA)),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                right: bannerWidth * 0.015,
                top: bannerHeight * 0.035,
                child: Container(
                  width: outerCircle,
                  height: outerCircle,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE8E8EA),
                  ),
                ),
              ),
              Positioned(
                right: bannerWidth * 0.015 + (outerCircle - innerCircle) / 2,
                top: bannerHeight * 0.035 + (outerCircle - innerCircle) / 2,
                child: Container(
                  width: innerCircle,
                  height: innerCircle,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF3F3F4),
                  ),
                ),
              ),
              Positioned(
                left: bannerWidth * 0.175,
                top: bannerHeight * 0.23,
                child: Row(
                  children: [
                    Container(
                      width: 2,
                      height: bannerHeight * 0.075,
                      color: const Color(0xFF8F94A3),
                    ),
                    SizedBox(width: bannerWidth * 0.015),
                    Text(
                      'NEW COLLECTION',
                      style: TextStyle(
                        color: const Color(0xFF8F94A3),
                        fontSize: bannerHeight * 0.06,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: bannerWidth * 0.175,
                top: bannerHeight * 0.49,
                child: Text(
                  'HANG OUT\n& PARTY',
                  style: TextStyle(
                    color: const Color(0xFF555967),
                    fontSize: bannerHeight * 0.115,
                    fontWeight: FontWeight.w300,
                    height: 1.35,
                  ),
                ),
              ),
              Positioned(
                right: bannerWidth * -0.13,
                bottom: -bannerHeight * 0.25,
                child: SizedBox(
                  width: bannerHeight * 1.65,
                  height: bannerHeight * 1.30,
                  child: Image.asset('assets/5.png', fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// TOP COLLECTION BANNER
// ============================================================

class CollectionBanner extends StatelessWidget {
  final String image;
  final String smallText;
  final String bigText;
  final double bannerHeight;

  const CollectionBanner({
    super.key,
    required this.image,
    required this.smallText,
    required this.bigText,
    required this.bannerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31),
      child: Container(
        width: double.infinity,
        height: bannerHeight,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8FA),
          borderRadius: BorderRadius.circular(9),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned(
              right: bannerHeight > 170 ? 60 : 28,
              top: bannerHeight > 170 ? 66 : 15,
              child: Container(
                width: bannerHeight > 180 ? 160 : 185,
                height: bannerHeight > 180 ? 125 : 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE4E4E6),
                ),
              ),
            ),
            Positioned(
              left: 22,
              top: bannerHeight > 180 ? 32 : 20,
              child: Row(
                children: [
                  Container(
                    width: 2,
                    height: 10,
                    color: const Color(0xFFBFC1C9),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    smallText,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF999CA6),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              top: bannerHeight > 180 ? 73 : 55,
              child: Text(
                bigText,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                  height: 1.35,
                  color: Color(0xFF5D6170),
                ),
              ),
            ),
            Positioned(
              right: bannerHeight > 180 ? 25 : 12,
              bottom: bannerHeight > 180 ? -20 : -18,
              child: SizedBox(
                width: bannerHeight > 180 ? 210 : 205,
                height: bannerHeight > 180 ? 270 : 220,
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BOTTOM COLLECTION CARD (T-Shirts / Dresses)
// ============================================================

class BottomCollectionCard extends StatelessWidget {
  final String image;
  final String label;
  final String text;
  final bool isDress;

  const BottomCollectionCard({
    super.key,
    required this.image,
    required this.label,
    required this.text,
    required this.isDress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 187,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8FA),
          borderRadius: BorderRadius.circular(9),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              left: isDress ? 11 : 95,
              top: 38,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777A84),
                ),
              ),
            ),
            Positioned(
              left: isDress ? 11 : 95,
              top: 72,
              child: SizedBox(
                width: isDress ? 80 : 67,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    height: 1.3,
                    color: Color(0xFF3E414B),
                  ),
                ),
              ),
            ),
            Positioned(
              left: isDress ? 72 : -7,
              bottom: -2,
              child: SizedBox(
                width: 110,
                height: 215,
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

