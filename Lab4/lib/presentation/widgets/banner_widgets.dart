
import 'package:flutter/material.dart';

// ============================================================
// REUSABLE NETWORK IMAGE
// ============================================================

class NetworkImageBox extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Alignment alignment;

  const NetworkImageBox({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    if (!imageUrl.startsWith('https://') &&
        !imageUrl.startsWith('http://')) {
      return const ColoredBox(
        color: Color(0xFFF1F1F3),
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Color(0xFF99999F),
          ),
        ),
      );
    }

    return Image.network(
      imageUrl,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        return const ColoredBox(
          color: Color(0xFFF1F1F3),
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Color(0xFF99999F),
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// AUTUMN COLLECTION
// ============================================================

class AutumnBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int activeSlide;
  final int slides;

  const AutumnBanner({
    super.key,
    required this.imageUrl,
    required this.title,
    this.activeSlide = 0,
    this.slides = 3,
  });

  Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: active ? 7 : 5,
      height: active ? 7 : 5,
      decoration: BoxDecoration(
        color: active
            ? Colors.white
            : Colors.white.withValues(alpha: 0.65),
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
              NetworkImageBox(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 18),
                child: SizedBox(
                  width: 132,
                  child: Text(
                    title,
                    style: const TextStyle(
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
                  children: [
                    for (int i = 0; i < slides; i++)
                      _dot(i == activeSlide),
                  ],
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
// NEW COLLECTION
// ============================================================

class NewCollectionBanner extends StatelessWidget {
  final String imageUrl;

  const NewCollectionBanner({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double bannerWidth = constraints.maxWidth;
        final double bannerHeight = bannerWidth / 2.38;

        return Container(
          width: double.infinity,
          height: bannerHeight,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F8FA),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // Image on the right, full banner height
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: bannerWidth * 0.48,
                child: NetworkImageBox(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),

              // Collection label
              Positioned(
                left: bannerWidth * 0.175,
                top: bannerHeight * 0.23,
                right: bannerWidth * 0.50,
                child: Row(
                  children: [
                    Container(
                      width: 2,
                      height: bannerHeight * 0.075,
                      color: const Color(0xFF8F94A3),
                    ),
                    SizedBox(width: bannerWidth * 0.015),
                    const Expanded(
                      child: Text(
                        'NEW COLLECTION',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF8F94A3),
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Collection title
              Positioned(
                left: bannerWidth * 0.175,
                top: bannerHeight * 0.49,
                right: bannerWidth * 0.50,
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
  final String imageUrl;
  final String smallText;
  final String bigText;
  final double bannerHeight;

  const CollectionBanner({
    super.key,
    required this.imageUrl,
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double imageWidth =
                constraints.maxWidth * 0.52;

            return Stack(
              children: [
                // Image on the right
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: imageWidth,
                  child: NetworkImageBox(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),

                // Small label on the left
                Positioned(
                  left: 22,
                  top: bannerHeight > 180 ? 32 : 20,
                  right: imageWidth + 12,
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        height: 10,
                        color: const Color(0xFFBFC1C9),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          smallText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF999CA6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main text on the left
                Positioned(
                  left: 22,
                  top: bannerHeight > 180 ? 73 : 55,
                  right: imageWidth + 12,
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
              ],
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// BOTTOM COLLECTION CARD
// ============================================================

class BottomCollectionCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final String text;
  final bool isDress;

  const BottomCollectionCard({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.text,
    required this.isDress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double cardWidth = constraints.maxWidth;
          final double imageWidth = cardWidth * 0.50;

          return Container(
            height: 187,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8FA),
              borderRadius: BorderRadius.circular(9),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Image on the outside edge
                Positioned(
                  left: isDress ? null : 0,
                  right: isDress ? 0 : null,
                  top: 0,
                  bottom: 0,
                  width: imageWidth,
                  child: NetworkImageBox(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),

                // Label
                Positioned(
                  left: isDress ? 11 : imageWidth + 7,
                  right: isDress ? imageWidth + 5 : 5,
                  top: 38,
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF777A84),
                    ),
                  ),
                ),

                // Description
                Positioned(
                  left: isDress ? 11 : imageWidth + 7,
                  right: isDress ? imageWidth + 5 : 5,
                  top: 72,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
