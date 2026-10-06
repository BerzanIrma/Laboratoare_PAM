

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../repositories/store_repository.dart';
import 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository repository;

  StoreCubit(this.repository) : super(const StoreState());

  // ============================================================
  // LOAD DATA (asincron, din assets/data/store.json)
  // ============================================================

  Future<void> loadStore() async {
    emit(state.copyWith(status: StoreStatus.loading));

    try {
      // mică întârziere ca să se vadă starea Loading (se poate șterge)
      await Future.delayed(const Duration(milliseconds: 700));

      final results = await Future.wait([
        repository.getCategories(),
        repository.getFeatureProducts(),
        repository.getRecommendedProducts(),
      ]);

      final categories = results[0] as List<Category>;
      final featureProducts = results[1] as List<Product>;
      final recommendedProducts = results[2] as List<Product>;

      final allProducts = _merge(featureProducts, recommendedProducts);

      // categoria selectată inițial vine din JSON ("selected": true)
      String? selectedId;
      for (final c in categories) {
        if (c.selected) {
          selectedId = c.id;
          break;
        }
      }
      selectedId ??= categories.isNotEmpty ? categories.first.id : null;

      if (allProducts.isEmpty) {
        emit(state.copyWith(
          status: StoreStatus.empty,
          categories: categories,
          selectedCategoryId: selectedId,
          featureProducts: featureProducts,
          recommendedProducts: recommendedProducts,
          filteredProducts: const [],
        ));
        return;
      }

      emit(state.copyWith(
        status: StoreStatus.success,
        categories: categories,
        selectedCategoryId: selectedId,
        featureProducts: featureProducts,
        recommendedProducts: recommendedProducts,
        filteredProducts: allProducts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StoreStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ============================================================
  // CATEGORY
  // ============================================================

  void selectCategory(String categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
  }

  // ============================================================
  // SEARCH / SORT / FILTER / RESET
  // ============================================================

  void searchProducts(String query) => _refreshProducts(searchQuery: query);

  void sortProducts(SortOption option) => _refreshProducts(sortOption: option);

  void filterProducts(FilterOption option) =>
      _refreshProducts(filterOption: option);

  void resetFilters() {
    _refreshProducts(
      searchQuery: '',
      sortOption: SortOption.none,
      filterOption: FilterOption.all,
    );
  }

  // ============================================================
  // FAVORITES
  // ============================================================

  void toggleFavorite(String productId) {
    final favorites = Set<String>.from(state.favoriteProductIds);

    if (!favorites.add(productId)) {
      favorites.remove(productId);
    }

    emit(state.copyWith(favoriteProductIds: favorites));
  }

  // ============================================================
  // INTERNAL
  // ============================================================

  /// Unește listele fără duplicate (după id).
  List<Product> _merge(List<Product> a, List<Product> b) {
    final Map<String, Product> map = {};
    for (final p in [...a, ...b]) {
      map[p.id] = p;
    }
    return map.values.toList();
  }

  void _refreshProducts({
    String? searchQuery,
    SortOption? sortOption,
    FilterOption? filterOption,
  }) {
    final currentSearch = searchQuery ?? state.searchQuery;
    final currentSort = sortOption ?? state.sortOption;
    final currentFilter = filterOption ?? state.filterOption;

    final query = currentSearch.toLowerCase().trim();

    // SEARCH
    List<Product> products = _merge(
      state.featureProducts,
      state.recommendedProducts,
    ).where((p) => query.isEmpty || p.name.toLowerCase().contains(query)).toList();

    // FILTER (după preț)
    switch (currentFilter) {
      case FilterOption.all:
        break;
      case FilterOption.under40:
        products = products.where((p) => p.price < 40).toList();
        break;
      case FilterOption.from40To70:
        products =
            products.where((p) => p.price >= 40 && p.price <= 70).toList();
        break;
      case FilterOption.over70:
        products = products.where((p) => p.price > 70).toList();
        break;
    }

    // SORT
    switch (currentSort) {
      case SortOption.none:
        break;
      case SortOption.priceLowToHigh:
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.nameAtoZ:
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    emit(state.copyWith(
      status: StoreStatus.success,
      searchQuery: currentSearch,
      sortOption: currentSort,
      filterOption: currentFilter,
      filteredProducts: products,
    ));
  }
}
 
