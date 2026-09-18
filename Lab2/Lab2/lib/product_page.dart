import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 375,
            ),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // PRODUCT IMAGE
                  SizedBox(
                    height: 290,
                    child: Stack(
                      children: [

                        // PRODUCT PHOTO
                        Positioned.fill(
                          child: Image.asset(
                            'assets/sportwear.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),

                        // BACK BUTTON
                        Positioned(
                          left: 18,
                          top: 18,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.chevron_left,
                                size: 20,
                                color: Color(0xFF555555),
                              ),
                            ),
                          ),
                        ),

                        // HEART BUTTON
                        Positioned(
                          right: 18,
                          top: 18,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.favorite,
                              size: 17,
                              color: Color(0xFFE96A6A),
                            ),
                          ),
                        ),

                        // PAGE INDICATORS
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _imageIndicator(true),
                              _imageIndicator(false),
                              _imageIndicator(false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==========================================================
                  // WHITE CONTENT

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        27,
                        20,
                        0,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ==================================================
                          // PRODUCT NAME + PRICE

                          Row(
                            children: [

                              const Expanded(
                                child: Text(
                                  'Sportwear Set',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const Text(
                                '\$ 80.00',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF111111),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 7),

                          // ==================================================
                          // STARS

                          Row(
                            children: [

                              ...List.generate(
                                5,
                                    (index) => const Padding(
                                  padding: EdgeInsets.only(right: 3),
                                  child: Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Color(0xFF4E9388),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 4),

                              const Text(
                                '(83)',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 13),

                          const Divider(
                            height: 1,
                            color: Color(0xFFF0F0F0),
                          ),

                          // ==================================================
                          // COLOR + SIZE

                          const SizedBox(height: 13),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // COLOR
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    const Text(
                                      'Color',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF999999),
                                      ),
                                    ),

                                    const SizedBox(height: 9),

                                    Row(
                                      children: [

                                        _colorCircle(
                                          const Color(0xFFE9C4AB),
                                          selected: true,
                                        ),

                                        _colorCircle(
                                          const Color(0xFF292929),
                                        ),

                                        _colorCircle(
                                          const Color(0xFFE85D63),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // SIZE
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    const Text(
                                      'Size',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF999999),
                                      ),
                                    ),

                                    const SizedBox(height: 7),

                                    Row(
                                      children: [

                                        _sizeCircle('S'),

                                        _sizeCircle('M'),

                                        _sizeCircle(
                                          'L',
                                          selected: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 13),

                          const Divider(
                            height: 1,
                            color: Color(0xFFF0F0F0),
                          ),

                          // ==================================================
                          // DESCRIPTION

                          const SizedBox(height: 13),

                          Row(
                            children: [

                              const Expanded(
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 17,
                                color: Color(0xFF333333),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            'Sportswear is no longer under culture, it is no '
                                'longer inside or cobbled together as it once was. '
                                'Sport is fashion today. The top is oversized in '
                                'fit and style, may need to size down.',
                            style: TextStyle(
                              fontSize: 8,
                              height: 1.55,
                              color: Color(0xFF888888),
                            ),
                          ),

                          const SizedBox(height: 3),

                          const Text(
                            'Read more',
                            style: TextStyle(
                              fontSize: 8,
                              color: Color(0xFF4E9388),
                            ),
                          ),

                          // ==================================================
                          // REVIEWS

                          const SizedBox(height: 24),

                          Row(
                            children: [

                              const Expanded(
                                child: Text(
                                  'Reviews',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 17,
                                color: Color(0xFF333333),
                              ),
                            ],
                          ),

                          const SizedBox(height: 17),

                          // ==================================================
                          // RATING SUMMARY

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // LEFT 4.9
                              SizedBox(
                                width: 75,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [

                                        const Text(
                                          '4.9',
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF333333),
                                          ),
                                        ),

                                        const SizedBox(width: 4),

                                        const Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 3,
                                          ),
                                          child: Text(
                                            'OUT OF 5',
                                            style: TextStyle(
                                              fontSize: 6,
                                              color: Color(0xFF999999),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    const Text(
                                      '83 ratings',
                                      style: TextStyle(
                                        fontSize: 6,
                                        color: Color(0xFF999999),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // RATING BARS
                              Expanded(
                                child: Column(
                                  children: [

                                    _ratingBar(
                                      number: '5',
                                      percent: '80%',
                                      value: 0.80,
                                    ),

                                    _ratingBar(
                                      number: '4',
                                      percent: '12%',
                                      value: 0.12,
                                    ),

                                    _ratingBar(
                                      number: '3',
                                      percent: '5%',
                                      value: 0.05,
                                    ),

                                    _ratingBar(
                                      number: '2',
                                      percent: '3%',
                                      value: 0.03,
                                    ),

                                    _ratingBar(
                                      number: '1',
                                      percent: '0%',
                                      value: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 9),

                          Row(
                            children: [

                              const Expanded(
                                child: Text(
                                  '47 Reviews',
                                  style: TextStyle(
                                    fontSize: 6,
                                    color: Color(0xFFBBBBBB),
                                  ),
                                ),
                              ),

                              const Text(
                                'WRITE A REVIEW',
                                style: TextStyle(
                                  fontSize: 6,
                                  color: Color(0xFFBBBBBB),
                                ),
                              ),

                              const SizedBox(width: 4),

                              const Icon(
                                Icons.edit,
                                size: 9,
                                color: Color(0xFFAAAAAA),
                              ),
                            ],
                          ),

                          // ==================================================
                          // REVIEW 1

                          const SizedBox(height: 24),

                          _review(
                            image: 'assets/pers1.jpg',
                            name: 'Jennifer Rose',
                            time: '5m ago',
                            text:
                            'I love it. Awesome customer service! Helped '
                                'me out with adding an additional item to my '
                                'order. Thanks again!',
                          ),

                          // ==================================================
                          // REVIEW 2

                          const SizedBox(height: 20),

                          _review(
                            image: 'assets/pers2.jpg',
                            name: 'Kelly Rihanna',
                            time: '9m ago',
                            text:
                            'I’m very happy with order, it was delivered '
                                'on and good quality. Recommended!',
                          ),

                          // ==================================================
                          // SIMILAR PRODUCT

                          const SizedBox(height: 25),

                          Row(
                            children: [

                              const Expanded(
                                child: Text(
                                  'Similar Product',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF222222),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 17,
                                color: Color(0xFF333333),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // ==================================================
                          // 3 PRODUCTS

                          Row(
                            children: [

                              Expanded(
                                child: _similarProduct(
                                  image: 'assets/crophoodie.jpg',
                                  name: 'Rise Crop Hoodie',
                                  price: '\$ 43.00',
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: _similarProduct(
                                  image: 'assets/criptop.jpg',
                                  name: 'Gym Crop Top',
                                  price: '\$ 39.99',
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: _similarProduct(
                                  image: 'assets/sport.jpg',
                                  name: 'Sport Sweater',
                                  price: '\$ 47.99',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 28),

                          // ==================================================
                          // ADD TO CART

                          Container(
                            width: double.infinity,
                            height: 46,
                            decoration: BoxDecoration(
                              color: const Color(0xFF333333),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [

                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),

                                SizedBox(width: 10),

                                Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          // ==================================================
                          // BOTTOM HOME INDICATOR

                          Center(
                            child: Container(
                              width: 90,
                              height: 3,
                              decoration: BoxDecoration(
                                color: const Color(0xFF333333),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // IMAGE INDICATOR

  static Widget _imageIndicator(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? const Color(0xFF555555)
            : const Color(0xFFBBBBBB),
      ),
    );
  }

  // ========================================================================
  // COLOR

  static Widget _colorCircle(
      Color color, {
        bool selected = false,
      }) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(right: 7),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: selected
            ? Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        )
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  // ========================================================================
  // SIZE

  static Widget _sizeCircle(
      String size, {
        bool selected = false,
      }) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected
            ? const Color(0xFF555555)
            : const Color(0xFFF5F5F5),
      ),
      child: Center(
        child: Text(
          size,
          style: TextStyle(
            fontSize: 8,
            color: selected
                ? Colors.white
                : const Color(0xFFBBBBBB),
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // RATING BAR

  static Widget _ratingBar({
    required String number,
    required String percent,
    required double value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [

          SizedBox(
            width: 10,
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 7,
                color: Color(0xFF999999),
              ),
            ),
          ),

          const Icon(
            Icons.star,
            size: 9,
            color: Color(0xFF4E9388),
          ),

          const SizedBox(width: 5),

          Expanded(
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E9388),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 7),

          SizedBox(
            width: 20,
            child: Text(
              percent,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 6,
                color: Color(0xFF999999),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // REVIEW

  static Widget _review({
    required String image,
    required String name,
    required String time,
    required String text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            // ROUND PHOTO
            ClipOval(
              child: Image.asset(
                image,
                width: 27,
                height: 27,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 6,
                          color: Color(0xFFBBBBBB),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 3),

                  Row(
                    children: List.generate(
                      5,
                          (index) => const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.star,
                          size: 8,
                          color: Color(0xFF4E9388),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        Text(
          text,
          style: const TextStyle(
            fontSize: 7,
            height: 1.45,
            color: Color(0xFF777777),
          ),
        ),
      ],
    );
  }

  // ========================================================================
  // SIMILAR PRODUCT

  static Widget _similarProduct({
    required String image,
    required String name,
    required String price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AspectRatio(
          aspectRatio: 0.74,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 7,
            color: Color(0xFF333333),
          ),
        ),

        const SizedBox(height: 3),

        Text(
          price,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Color(0xFF222222),
          ),
        ),
      ],
    );
  }
}