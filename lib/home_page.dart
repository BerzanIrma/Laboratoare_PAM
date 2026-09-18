import 'package:flutter/material.dart';
import 'product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 28,
              right: 28,
              top: 15,
              bottom: 20,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ============================================================
                // HEADER
                // ============================================================

                SizedBox(
                  height: 55,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // MENU
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Icons.menu,
                          size: 24,
                          color: Color(0xFF111111),
                        ),
                      ),

                      // GEMSTORE
                      const Expanded(
                        child: Center(
                          child: Text(
                            'GemStore',
                            style: TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // BELL + RED DOT
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Stack(
                          children: [

                            const Center(
                              child: Icon(
                                Icons.notifications_none,
                                size: 24,
                                color: Color(0xFF111111),
                              ),
                            ),

                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE85D5D),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // CATEGORIES
                // ============================================================

                SizedBox(
                  height: 105,
                  child: Row(
                    children: [

                      // WOMEN
                      _category(
                        icon: const FemaleSymbol(),
                        title: 'Women',
                        selected: true,
                      ),

                      // MEN
                      _category(
                        icon: const MaleSymbol(),
                        title: 'Men',
                        selected: false,
                      ),

                      // ACCESSORIES
                      _category(
                        icon: const GlassesIcon(),
                        title: 'Accessories',
                        selected: false,
                      ),

                      // BEAUTY
                      _category(
                        icon: const BeautyIcon(),
                        title: 'Beauty',
                        selected: false,
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // AUTUMN COLLECTION
                // ============================================================

                Container(
                  width: double.infinity,
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC0A27F),
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Stack(
                    children: [

                      Positioned.fill(
                        child: Image.asset(
                          'assets/collection.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      const Positioned(
                        right: 15,
                        top: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: 150,
                          child: Center(
                            child: Text(
                              'Autumn\nCollection\n2026',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // FEATURE PRODUCTS TITLE
                // ============================================================

                SizedBox(
                  height: 58,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Expanded(
                        child: Text(
                          'Feature Products',
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Text(
                        'Show all',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // FEATURE PRODUCTS
                // ============================================================

                SizedBox(
                  height: 205,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // SWEATER
                        _featureProduct(
                          image: 'assets/sweater.jpg',
                          name: 'Turtleneck Sweater',
                          price: '\$ 39.99',
                        ),

                        const SizedBox(width: 12),

                        // DRESS
                        _featureProduct(
                          image: 'assets/dress.jpg',
                          name: 'Long Sleeve Dress',
                          price: '\$ 45.00',
                        ),

                        const SizedBox(width: 12),

                        // SPORTSWEAR
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const ProductPage(),
                              ),
                            );
                          },
                          child: _featureProduct(
                            image: 'assets/sportwear.jpg',
                            name: 'Sportswear',
                            price: '\$ 80.00',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ============================================================
                // HANG OUT & PARTY
                // ============================================================

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  height: 140,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F9),
                    borderRadius: BorderRadius.circular(9),
                  ),

                  child: Stack(
                    children: [

                      Positioned.fill(
                        child: Image.asset(
                          'assets/newcollection.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              const Text(
                                '|  NEW COLLECTION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                              ),

                              const SizedBox(height: 12),

                              const Text(
                                'HANG OUT\n& PARTY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // RECOMMENDED TITLE
                // ============================================================

                SizedBox(
                  height: 58,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Expanded(
                        child: Text(
                          'Recommended',
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Text(
                        'Show all',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // RECOMMENDED PRODUCTS
                // ============================================================

                SizedBox(
                  height: 62,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [

                        _recommendedProduct(
                          image: 'assets/hoodie.jpg',
                          name: 'White fashion hoodie',
                          price: '\$ 29.00',
                        ),

                        const SizedBox(width: 12),

                        _recommendedProduct(
                          image: 'assets/tshirt.jpg',
                          name: 'Cotton T-shirt',
                          price: '\$ 30.00',
                        ),
                      ],
                    ),
                  ),
                ),

                // ============================================================
                // TOP COLLECTION TITLE
                // ============================================================

                SizedBox(
                  height: 58,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Expanded(
                        child: Text(
                          'Top Collection',
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Text(
                        'Show all',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // TOP COLLECTION 1 - SALE
                // ============================================================

                Container(
                  width: double.infinity,
                  height: 125,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),

                  child: Stack(
                    children: [

                      Positioned.fill(
                        child: Image.asset(
                          'assets/sale.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              const Text(
                                '|  Sale up to 40%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                              ),

                              const SizedBox(height: 12),

                              const Text(
                                'FOR SLIM\n& BEAUTY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // TOP COLLECTION 2 - SUMMER
                // ============================================================

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  height: 187,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F9),
                    borderRadius: BorderRadius.circular(9),
                  ),

                  child: Stack(
                    children: [

                      Positioned.fill(
                        child: Image.asset(
                          'assets/summer.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              const Text(
                                '|  Summer Collection 2021',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                              ),

                              const SizedBox(height: 15),

                              const SizedBox(
                                width: 190,
                                child: Text(
                                  'Most sexy\n& fabulous\ndesign',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // BOTTOM TWO
                // ============================================================

                const SizedBox(height: 12),

                SizedBox(
                  height: 172,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ========================================================
                      // T-SHIRTS
                      // ========================================================

                      Expanded(
                        child: Container(
                          height: 150,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F9),
                            borderRadius:
                            BorderRadius.circular(9),
                          ),

                          child: Stack(
                            children: [

                              Positioned.fill(
                                child: Image.asset(
                                  'assets/tshirt.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned.fill(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [

                                    const Text(
                                      'T-Shirts',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    const Text(
                                      'The Office\nLife',
                                      textAlign:
                                      TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // ========================================================
                      // DRESSES
                      // ========================================================

                      Expanded(
                        child: Container(
                          height: 150,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F9),
                            borderRadius:
                            BorderRadius.circular(9),
                          ),

                          child: Stack(
                            children: [

                              Positioned.fill(
                                child: Image.asset(
                                  'assets/dresses.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned.fill(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [

                                    const Text(
                                      'Dresses',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    const Text(
                                      'Elegant\nDesign',
                                      textAlign:
                                      TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // CATEGORY
  // ========================================================================

  static Widget _category({
    required Widget icon,
    required String title,
    required bool selected,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 40,
            height: 40,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: selected
                  ? const Color(0xFF3B2E2A)
                  : const Color(0xFFF4F4F5),

              border: selected
                  ? Border.all(
                color: const Color(0xFF3B2E2A),
                width: 2,
              )
                  : null,
            ),

            child: Center(
              child: icon,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: selected
                  ? const Color(0xFF3B2E2A)
                  : const Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // FEATURE PRODUCT
  // ========================================================================

  static Widget _featureProduct({
    required String image,
    required String name,
    required String price,
  }) {
    return SizedBox(
      width: 112,
      height: 205,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Image.asset(
            image,
            width: 112,
            height: 151,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 7),

          Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF222222),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            price,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // RECOMMENDED PRODUCT
  // ========================================================================

  static Widget _recommendedProduct({
    required String image,
    required String name,
    required String price,
  }) {
    return Container(
      width: 188,
      height: 58,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: const Color(0xFFF0F0F0),
        ),
      ),

      child: Row(
        children: [

          Image.asset(
            image,
            width: 65,
            height: 58,
            fit: BoxFit.cover,
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),

              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF333333),
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================================
// FEMALE SYMBOL
// ============================================================================

class FemaleSymbol extends StatelessWidget {
  const FemaleSymbol({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(24, 27),
      painter: FemalePainter(),
    );
  }
}

class FemalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    // CIRCLE
    canvas.drawCircle(
      const Offset(12, 9),
      6.5,
      paint,
    );

    // VERTICAL
    canvas.drawLine(
      const Offset(12, 15.5),
      const Offset(12, 23),
      paint,
    );

    // HORIZONTAL
    canvas.drawLine(
      const Offset(8, 19),
      const Offset(16, 19),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


// ============================================================================
// MALE SYMBOL
// ============================================================================

class MaleSymbol extends StatelessWidget {
  const MaleSymbol({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(24, 27),
      painter: MalePainter(),
    );
  }
}

class MalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF999999)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    // CIRCLE
    canvas.drawCircle(
      const Offset(9.5, 14),
      6.5,
      paint,
    );

    // DIAGONAL ARROW
    canvas.drawLine(
      const Offset(14, 9.5),
      const Offset(21, 2.5),
      paint,
    );

    // ARROW HEAD
    canvas.drawLine(
      const Offset(17, 2.5),
      const Offset(21, 2.5),
      paint,
    );

    canvas.drawLine(
      const Offset(21, 2.5),
      const Offset(21, 6.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


// ============================================================================
// GLASSES
// ============================================================================

class GlassesIcon extends StatelessWidget {
  const GlassesIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(25, 20),
      painter: GlassesPainter(),
    );
  }
}

class GlassesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF777777)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // LEFT GLASS
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(
          1,
          6,
          9,
          7,
        ),
        const Radius.circular(2),
      ),
      paint,
    );

    // RIGHT GLASS
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(
          15,
          6,
          9,
          7,
        ),
        const Radius.circular(2),
      ),
      paint,
    );

    // BRIDGE
    canvas.drawLine(
      const Offset(10, 8),
      const Offset(15, 8),
      paint,
    );

    // LEFT ARM
    canvas.drawLine(
      const Offset(1, 7),
      const Offset(0, 5),
      paint,
    );

    // RIGHT ARM
    canvas.drawLine(
      const Offset(24, 7),
      const Offset(25, 5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


// ============================================================================
// BEAUTY / BRUSH
// ============================================================================

class BeautyIcon extends StatelessWidget {
  const BeautyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(24, 25),
      painter: BeautyPainter(),
    );
  }
}

class BeautyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF777777)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    // BRUSH BODY
    canvas.drawLine(
      const Offset(8, 22),
      const Offset(16, 7),
      paint,
    );

    // TOP
    canvas.drawLine(
      const Offset(16, 7),
      const Offset(20, 3),
      paint,
    );

    canvas.drawLine(
      const Offset(18, 3),
      const Offset(21, 3),
      paint,
    );

    // BOTTOM
    canvas.drawLine(
      const Offset(8, 22),
      const Offset(5, 19),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}