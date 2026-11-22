

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/store_cubit.dart';
import 'cubit/store_state.dart';
import 'models/category.dart';
import 'models/product.dart';
import 'product_page.dart';
import 'widgets/banner_widgets.dart';
import 'widgets/category_item.dart';
import 'widgets/product_widgets.dart';
import 'widgets/state_views.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoreCubit>();

    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        switch (state.status) {
          case StoreStatus.initial:
          case StoreStatus.loading:
            return const LoadingView();

          case StoreStatus.error:
            return ErrorView(
              message: state.errorMessage ?? 'Unknown error',
              onRetry: cubit.loadStore,
            );

          case StoreStatus.empty:
            return EmptyView(onReload: cubit.loadStore);

          case StoreStatus.success:
            return _HomeContent(state: state);
        }
      },
    );
  }
}

// ============================================================
// HOME CONTENT (SUCCESS)
// ============================================================

class _HomeContent extends StatelessWidget {
  final StoreState state;

  const _HomeContent({required this.state});

  void _openProduct(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductPage()),
    );
  }

  Widget _productList(BuildContext context, List<Product> products) {
    final cubit = context.read<StoreCubit>();

    return SizedBox(
      height: 242,
      child: ListView(
        padding: const EdgeInsets.only(left: 34),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          for (final product in products)
            ProductCard(
              product: product,
              isFavorite: state.isFavorite(product.id),
              onTap: () => _openProduct(context, product),
              onFavoriteTap: () => cubit.toggleFavorite(product.id),
            ),
        ],
      ),
    );
  }

  CategoryType _categoryType(Category category) {
    switch (category.name.toLowerCase()) {
      case 'men':
        return CategoryType.men;
      case 'accessories':
        return CategoryType.accessories;
      case 'beauty':
        return CategoryType.beauty;
      default:
        return CategoryType.women;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoreCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // =====================================================
              // TOP BAR
              // =====================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: 58,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.menu,
                        size: 27,
                        color: Color(0xFF303030),
                      ),
                      const Text(
                        'GemStore',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_none_outlined,
                            size: 29,
                            color: Color(0xFF222222),
                          ),
                          Positioned(
                            right: -1,
                            top: 0,
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF3B73),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // =====================================================
              // CATEGORIES (din JSON)
              // =====================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final category in state.categories)
                      CategoryItem(
                        title: category.name,
                        type: _categoryType(category),
                        selected: category.id == state.selectedCategoryId,
                        onTap: () => cubit.selectCategory(category.id),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =====================================================
              // SEARCH + SORT + FILTER
              // =====================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 31),
                child: TextField(
                  onChanged: cubit.searchProducts,
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    hintStyle: const TextStyle(
                      color: Color(0xFFAAAAAE),
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF777A84),
                      size: 21,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _sortMenu(cubit),
                        _filterMenu(cubit),
                      ],
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F7F8),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // =====================================================
              // RESULTS (search / filter / sort active)
              // =====================================================
              if (state.isFiltering) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Search Results',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${state.filteredProducts.length} products',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF99999F),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: cubit.resetFilters,
                            child: const Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFF3B73),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 21),
                if (state.filteredProducts.isEmpty)
                  const NoResults()
                else
                  _productList(context, state.filteredProducts),
                const SizedBox(height: 30),
              ],

              // =====================================================
              // DEFAULT HOME
              // =====================================================
              if (!state.isFiltering) ...[
                const AutumnBanner(),

                const SizedBox(height: 31),

                const SectionTitle(title: 'Feature Products'),
                const SizedBox(height: 21),
                _productList(context, state.featureProducts),

                const SizedBox(height: 17),

                const NewCollectionBanner(),

                const SizedBox(height: 35),

                const SectionTitle(title: 'Recommended'),
                const SizedBox(height: 23),

                SizedBox(
                  height: 65,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 31),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      for (final product in state.recommendedProducts)
                        RecommendedCard(
                          product: product,
                          onTap: () => _openProduct(context, product),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 34),

                const SectionTitle(title: 'Top Collection'),
                const SizedBox(height: 27),

                const CollectionBanner(
                  image: 'assets/8.png',
                  smallText: 'Sale up to 40%',
                  bigText: 'FOR SLIM\n& BEAUTY',
                  bannerHeight: 137,
                ),

                const SizedBox(height: 15),

                const CollectionBanner(
                  image: 'assets/9.png',
                  smallText: 'Summer Collection 2021',
                  bigText: 'Most sexy\n& fabulous\ndesign',
                  bannerHeight: 219,
                ),

                const SizedBox(height: 15),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 31),
                  child: Row(
                    children: [
                      BottomCollectionCard(
                        image: 'assets/10.png',
                        label: 'T-Shirts',
                        text: 'The\nOffice\nLife',
                        isDress: false,
                      ),
                      SizedBox(width: 10),
                      BottomCollectionCard(
                        image: 'assets/11.png',
                        label: 'Dresses',
                        text: 'Elegant\nDesign',
                        isDress: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SORT MENU
  // ============================================================

  Widget _sortMenu(StoreCubit cubit) {
    return PopupMenuButton<SortOption>(
      tooltip: 'Sort',
      icon: Icon(
        Icons.swap_vert,
        size: 21,
        color: state.sortOption == SortOption.none
            ? const Color(0xFF777A84)
            : const Color(0xFFFF3B73),
      ),
      initialValue: state.sortOption,
      onSelected: cubit.sortProducts,
      itemBuilder: (_) => const [
        PopupMenuItem(value: SortOption.none, child: Text('Default')),
        PopupMenuItem(
          value: SortOption.priceLowToHigh,
          child: Text('Price: low to high'),
        ),
        PopupMenuItem(
          value: SortOption.priceHighToLow,
          child: Text('Price: high to low'),
        ),
        PopupMenuItem(value: SortOption.nameAtoZ, child: Text('Name: A-Z')),
      ],
    );
  }

  // ============================================================
  // FILTER MENU
  // ============================================================

  Widget _filterMenu(StoreCubit cubit) {
    return PopupMenuButton<FilterOption>(
      tooltip: 'Filter',
      icon: Icon(
        Icons.tune,
        size: 20,
        color: state.filterOption == FilterOption.all
            ? const Color(0xFF777A84)
            : const Color(0xFFFF3B73),
      ),
      initialValue: state.filterOption,
      onSelected: cubit.filterProducts,
      itemBuilder: (_) => const [
        PopupMenuItem(value: FilterOption.all, child: Text('All prices')),
        PopupMenuItem(value: FilterOption.under40, child: Text('Under 40')),
        PopupMenuItem(value: FilterOption.from40To70, child: Text('40 - 70')),
        PopupMenuItem(value: FilterOption.over70, child: Text('Over 70')),
      ],
    );
  }
}
 
