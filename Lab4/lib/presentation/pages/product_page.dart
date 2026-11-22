
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/store_cubit.dart';
import '../cubit/store_state.dart';
import '../../domain/entities/product.dart';
class ProductPage extends StatefulWidget {
  final Product? selectedProduct;

  const ProductPage({
    super.key,
    this.selectedProduct,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _selectedImage = 0;
  String? _selectedColor;
  String? _selectedSize;
  bool _descriptionExpanded = false;

  Map<String, dynamic> _map(dynamic value) {
    if (value is Map<String, dynamic>) return value;

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return <String, dynamic>{};
  }

  List<dynamic> _list(dynamic value) {
    return value is List ? value : <dynamic>[];
  }

  String _string(dynamic value, [String fallback = '']) {
    if (value == null) return fallback;

    final result = value.toString();

    return result.isEmpty ? fallback : result;
  }

  double _number(dynamic value, [double fallback = 0]) {
    if (value is num) return value.toDouble();

    return double.tryParse(value?.toString() ?? '') ?? fallback;
  }

  Color _parseColor(dynamic value) {
    final map = _map(value);

    final hex = _string(
      map.isNotEmpty
          ? map['value'] ??
          map['hex'] ??
          map['color'] ??
          map['code']
          : value,
      '#E9C5AC',
    ).replaceAll('#', '').replaceAll('0x', '');

    final normalized = hex.length == 6 ? 'FF$hex' : hex;

    return Color(
      int.tryParse(normalized, radix: 16) ?? 0xFFE9C5AC,
    );
  }

  String _colorId(dynamic value) {
    final map = _map(value);

    if (map.isNotEmpty) {
      return _string(
        map['id'] ?? map['name'] ?? map['value'],
      );
    }

    return _string(value);
  }

  String _imageFrom(dynamic value) {
    final map = _map(value);

    if (map.isNotEmpty) {
      return _string(
        map['imageUrl'] ?? map['url'] ?? map['mainImageUrl'],
      );
    }

    return _string(value);
  }

  String _price(dynamic product) {
    final map = _map(product);
    final currency = _string(map['currency'], 'USD');
    final price = _number(map['price']);

    return '$currency ${price.toStringAsFixed(2)}';
  }

  Widget _networkImage(
      String url, {
        BoxFit fit = BoxFit.cover,
        Alignment alignment = Alignment.center,
      }) {
    if (!url.startsWith('http://') &&
        !url.startsWith('https://')) {
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
      url,
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        // Datele produsului primite din API
        final root = _map(state.productPageData);

        final productPage = _map(root['productPage']).isNotEmpty
            ? _map(root['productPage'])
            : root;

        final apiProduct = _map(productPage['product']);
        final selectedProduct = widget.selectedProduct;

        final Map<String, dynamic> product;

        if (selectedProduct == null ||
            selectedProduct.id == apiProduct['id']?.toString()) {
          product = apiProduct;
        } else {
          product = {
            'id': selectedProduct.id,
            'name': selectedProduct.name,
            'price': selectedProduct.price,
            'currency': selectedProduct.currency,
            'mainImageUrl': selectedProduct.imageUrl,
            'imageUrl': selectedProduct.imageUrl,
            'galleryImageUrls': <dynamic>[],
            'availableColors': <dynamic>[],
            'availableSizes': <dynamic>[],
            'reviews': <dynamic>[],
            'similarProducts': <dynamic>[],
            'ratingBreakdown': <dynamic>[],
            'rating': 0,
            'ratingCount': 0,
            'description': '',
            'actions': {
              'canAddToCart': true,
              'addToCartLabel': 'Add To Cart',
            },
          };
        }
        if (product.isEmpty) {
          if (state.status == StoreStatus.loading ||
              state.status == StoreStatus.initial) {
            return const Scaffold(
              backgroundColor: Color(0xFFF7F7F7),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF7F7F7),
              title: const Text('Product'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.errorMessage ??
                      'Product data is not available.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        // Imaginile produsului
        final gallery = _list(product['galleryImageUrls'])
            .map(_imageFrom)
            .where((url) => url.isNotEmpty)
            .toList();

        final mainImage = _string(
          product['mainImageUrl'] ?? product['imageUrl'],
        );

        final images = <String>[
          if (mainImage.isNotEmpty) mainImage,
          ...gallery.where((url) => url != mainImage),
        ];

        // Datele produsului
        final availableColors = _list(product['availableColors']);
        final availableSizes = _list(product['availableSizes']);
        final reviews = _list(product['reviews']);
        final similarProducts = _list(product['similarProducts']);
        final breakdown = _list(product['ratingBreakdown']);

        final rating = _number(product['rating']);

        final ratingCount = product['ratingCount'] ??
            product['reviewCount'] ??
            product['reviewsCount'] ??
            0;

        final description = _string(product['description']);

        final productId = _string(product['id']);

        // Favorite este gestionat centralizat de StoreCubit
        final isFavorite = state.isFavorite(productId);

        final actions = _map(product['actions']);

        final canAddToCart =
            actions['canAddToCart'] != false;

        final addToCartLabel = _string(
          actions['addToCartLabel'],
          'Add To Cart',
        );

        final currentColor = _selectedColor ??
            _string(product['selectedColor']);

        final currentSize = _selectedSize ??
            _string(product['selectedSize']);

        final safeImageIndex = images.isEmpty
            ? 0
            : _selectedImage.clamp(0, images.length - 1).toInt();

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 375),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: [
                            // PRODUCT IMAGE GALLERY
                            SizedBox(
                              height: 350,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: 109,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Container(
                                        width: 300,
                                        height: 225,
                                        decoration:
                                        const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFF3E8E3),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned.fill(
                                    child: Transform.translate(
                                      offset: const Offset(0, 85),
                                      child: Transform.scale(
                                        scale: 1.5,
                                        child: images.isEmpty
                                            ? const SizedBox.shrink()
                                            : _networkImage(
                                          images[safeImageIndex],
                                          fit: BoxFit.contain,
                                          alignment: Alignment
                                              .bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Back button
                                  Positioned(
                                    left: 18,
                                    top: 18,
                                    child: GestureDetector(
                                      onTap: () =>
                                          Navigator.pop(context),
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.08),
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

                                  // Favorite button
                                  Positioned(
                                    right: 18,
                                    top: 18,
                                    child: GestureDetector(
                                      onTap: productId.isEmpty
                                          ? null
                                          : () {
                                        final newStatus =
                                        !state.isFavorite(
                                          productId,
                                        );

                                        context
                                            .read<StoreCubit>()
                                            .toggleFavorite(
                                          productId,
                                        );

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              newStatus
                                                  ? 'Added to favorites'
                                                  : 'Removed from favorites',
                                            ),
                                            duration:
                                            const Duration(
                                              seconds: 1,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.08),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 17,
                                          color: const Color(0xFFE96A6A),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Image indicators
                                  if (images.length > 1)
                                    Positioned(
                                      bottom: 10,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: List.generate(
                                          images.length,
                                              (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedImage = index;
                                              });
                                            },
                                            child: Container(
                                              margin:
                                              const EdgeInsets
                                                  .symmetric(
                                                horizontal: 3,
                                              ),
                                              width: 5,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: index ==
                                                    safeImageIndex
                                                    ? const Color(
                                                  0xFF555555,
                                                )
                                                    : const Color(
                                                  0xFFBBBBBB,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // PRODUCT DETAILS
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                27,
                                20,
                                0,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // Name and price
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _string(
                                            product['name'],
                                            'Product',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _price(product),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF111111),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 7),

                                  // Rating
                                  Row(
                                    children: [
                                      ...List.generate(
                                        5,
                                            (index) => Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            right: 3,
                                          ),
                                          child: Icon(
                                            index < rating.round()
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 14,
                                            color: const Color(
                                              0xFF4E9388,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '($ratingCount)',
                                        style: const TextStyle(
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
                                  const SizedBox(height: 13),

                                  // COLOR AND SIZE
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
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
                                            Wrap(
                                              spacing: 2,
                                              runSpacing: 5,
                                              children: [
                                                for (final item
                                                in availableColors)
                                                  _buildColorChoice(
                                                    item,
                                                    currentColor,
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
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
                                            Wrap(
                                              spacing: 2,
                                              runSpacing: 5,
                                              children: [
                                                for (final item
                                                in availableSizes)
                                                  _buildSizeChoice(
                                                    item,
                                                    currentSize,
                                                    product[
                                                    'sizeAvailability'],
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
                                  const SizedBox(height: 13),

                                  // DESCRIPTION
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _descriptionExpanded =
                                        !_descriptionExpanded;
                                      });
                                    },
                                    child: Row(
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
                                        Icon(
                                          _descriptionExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          size: 17,
                                          color: const Color(0xFF333333),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  if (description.isNotEmpty)
                                    Text(
                                      description,
                                      maxLines: _descriptionExpanded
                                          ? null
                                          : 4,
                                      overflow: _descriptionExpanded
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 8,
                                        height: 1.55,
                                        color: Color(0xFF888888),
                                      ),
                                    ),

                                  if (description.length > 100)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _descriptionExpanded =
                                          !_descriptionExpanded;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(top: 3),
                                        child: Text(
                                          _descriptionExpanded
                                              ? 'Read less'
                                              : 'Read more',
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Color(0xFF4E9388),
                                          ),
                                        ),
                                      ),
                                    ),

                                  // REVIEWS
                                  const SizedBox(height: 24),

                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Reviews',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 17,
                                        color: Color(0xFF333333),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 17),

                                  // Rating summary
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
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
                                                Text(
                                                  rating.toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    fontSize: 23,
                                                    fontWeight:
                                                    FontWeight.w500,
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
                                                      color: Color(
                                                        0xFF999999,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '$ratingCount ratings',
                                              style: const TextStyle(
                                                fontSize: 6,
                                                color: Color(0xFF999999),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            for (int star = 5;
                                            star >= 1;
                                            star--)
                                              _ratingBarFromJson(
                                                star,
                                                breakdown,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 9),

                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Reviews',
                                          style: TextStyle(
                                            fontSize: 6,
                                            color: Color(0xFFBBBBBB),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'WRITE A REVIEW',
                                        style: TextStyle(
                                          fontSize: 6,
                                          color: Color(0xFFBBBBBB),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.edit,
                                        size: 9,
                                        color: Color(0xFFAAAAAA),
                                      ),
                                    ],
                                  ),

                                  for (final review in reviews) ...[
                                    const SizedBox(height: 20),
                                    _buildReview(review),
                                  ],

                                  // SIMILAR PRODUCTS
                                  const SizedBox(height: 25),

                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Similar Product',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 17,
                                        color: Color(0xFF333333),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 15),

                                  SizedBox(
                                    height: 205,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                      const BouncingScrollPhysics(),
                                      itemCount: similarProducts.length,
                                      separatorBuilder: (_, __) =>
                                      const SizedBox(width: 12),
                                      itemBuilder: (context, index) {
                                        final item = _map(
                                          similarProducts[index],
                                        );

                                        return SizedBox(
                                          width: 125,
                                          child: _buildSimilarProduct(item),
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 22),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ADD TO CART
                    GestureDetector(
                      onTap: canAddToCart
                          ? () {
                        if (availableSizes.isNotEmpty &&
                            currentSize.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select a size.',
                              ),
                            ),
                          );
                          return;
                        }

                        final selectedSize =
                        currentSize.isEmpty
                            ? 'not selected'
                            : currentSize;

                        final selectedColor =
                        currentColor.isEmpty
                            ? 'not selected'
                            : currentColor;

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              '$addToCartLabel: '
                                  '${_string(product['name'], 'Product')} '
                                  '(size: $selectedSize, '
                                  'color: $selectedColor).',
                            ),
                          ),
                        );
                      }
                          : null,
                      child: Container(
                        width: double.infinity,
                        height: 98,
                        decoration: const BoxDecoration(
                          color: Color(0xFF333333),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_bag,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  addToCartLabel,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: 110,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // COLOR OPTION
  Widget _buildColorChoice(
      dynamic item,
      String selectedColor,
      ) {
    final id = _colorId(item);
    final color = _parseColor(item);
    final selected = selectedColor == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = id;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 5),
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
      ),
    );
  }

  // SIZE OPTION
  Widget _buildSizeChoice(
      dynamic item,
      String selectedSize,
      dynamic availability,
      ) {
    final size = item is Map
        ? _string(
      _map(item)['name'] ?? _map(item)['value'],
    )
        : _string(item);

    final selected = selectedSize == size;
    final availabilityMap = _map(availability);

    final available = availabilityMap.isEmpty
        ? true
        : availabilityMap[size] != false;

    return GestureDetector(
      onTap: available
          ? () {
        setState(() {
          _selectedSize = size;
        });
      }
          : null,
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 5),
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
              color: !available
                  ? const Color(0xFFDDDDDD)
                  : selected
                  ? Colors.white
                  : const Color(0xFF777777),
            ),
          ),
        ),
      ),
    );
  }

  // RATING BAR
  Widget _ratingBarFromJson(
      int star,
      List<dynamic> breakdown,
      ) {
    final items = breakdown.map(_map).toList();

    final item = items.firstWhere(
          (entry) => _number(entry['stars']).toInt() == star,
      orElse: () => <String, dynamic>{
        'stars': star,
        'percentage': 0,
      },
    );

    final percentage = _number(item['percentage']);
    final value = (percentage / 100).clamp(0.0, 1.0).toDouble();

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: 10,
            child: Text(
              '$star',
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
            width: 25,
            child: Text(
              '${percentage.round()}%',
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

  // REVIEW
  Widget _buildReview(dynamic value) {
    final review = _map(value);

    final avatar = _string(review['avatarUrl']);
    final name = _string(review['author'], 'Customer');
    final time = _string(review['createdAtLabel']);
    final text = _string(review['text']);
    final rating = _number(review['rating'], 5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 27,
                height: 27,
                child: _networkImage(avatar),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
                          (index) => Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Icon(
                          index < rating.round()
                              ? Icons.star
                              : Icons.star_border,
                          size: 8,
                          color: const Color(0xFF4E9388),
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

  // SIMILAR PRODUCT CARD
  Widget _buildSimilarProduct(
      Map<String, dynamic> product,
      ) {
    final image = _string(
      product['imageUrl'] ?? product['mainImageUrl'],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 0.74,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: _networkImage(image),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _string(product['name'], 'Product'),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 7,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          _price(product),
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
