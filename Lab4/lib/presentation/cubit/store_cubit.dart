
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/store_repository.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products.dart';
import 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository repository;
  final GetCategories getCategories;
  final GetProducts getProducts;

  StoreCubit({
    required this.repository,
    required this.getCategories,
    required this.getProducts,
  }) : super(const StoreState());

  // Incarcarea datelor din API
  Future<void> loadStore() async {
    emit(state.copyWith(
      status: StoreStatus.loading,
      clearErrorMessage: true,
    ));

    try {
      // Preluarea datelor in paralel
      final results = await Future.wait([
        getCategories(),
        getProducts.getFeatureProducts(),
        getProducts.getRecommendedProducts(),
        repository.getHomePageData(),
        repository.getProductPageData(),
      ]);

      final categories = results[0] as List<Category>;
      final featureProducts = results[1] as List<Product>;
      final recommendedProducts = results[2] as List<Product>;

      final homePageData =
      results[3] as Map<String, dynamic>;

      final productPageData =
      results[4] as Map<String, dynamic>;

      // Combinarea produselor fara duplicate
      final allProducts = _merge(
        featureProducts,
        recommendedProducts,
      );

      // Identificarea categoriei selectate initial
      String? selectedId;

      for (final category in categories) {
        if (category.selected) {
          selectedId = category.id;
          break;
        }
      }

      selectedId ??=
      categories.isNotEmpty ? categories.first.id : null;

      // Initializarea produsului favorit din API
      final productData = productPageData['product'] is Map
          ? Map<String, dynamic>.from(
        productPageData['product'],
      )
          : <String, dynamic>{};

      final actions = productData['actions'] is Map
          ? Map<String, dynamic>.from(
        productData['actions'],
      )
          : <String, dynamic>{};

      final productId = productData['id']?.toString();

      final favorites = Set<String>.from(
        state.favoriteProductIds,
      );

      if (productId != null && productId.isNotEmpty) {
        if (actions['isFavorite'] == true) {
          favorites.add(productId);
        } else {
          favorites.remove(productId);
        }
      }

      // Actualizarea starii aplicatiei
      emit(state.copyWith(
        status: allProducts.isEmpty
            ? StoreStatus.empty
            : StoreStatus.success,
        categories: categories,
        selectedCategoryId: selectedId,
        featureProducts: featureProducts,
        recommendedProducts: recommendedProducts,
        filteredProducts: allProducts,
        homePageData: homePageData,
        productPageData: productPageData,
        favoriteProductIds: favorites,
        searchQuery: '',
        sortOption: SortOption.none,
        filterOption: FilterOption.all,
        clearErrorMessage: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StoreStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // Selectarea unei categorii
  void selectCategory(String categoryId) {
    emit(state.copyWith(
      selectedCategoryId: categoryId,
    ));
  }

  // Cautarea produselor
  void searchProducts(String query) {
    _refreshProducts(searchQuery: query);
  }

  // Sortarea produselor
  void sortProducts(SortOption option) {
    _refreshProducts(sortOption: option);
  }

  // Filtrarea produselor dupa pret
  void filterProducts(FilterOption option) {
    _refreshProducts(filterOption: option);
  }

  // Resetarea filtrelor si cautarii
  void resetFilters() {
    _refreshProducts(
      searchQuery: '',
      sortOption: SortOption.none,
      filterOption: FilterOption.all,
    );
  }

  // Adaugarea sau eliminarea unui produs din favorite
  void toggleFavorite(String productId) {
    if (productId.isEmpty) return;

    final favorites = Set<String>.from(
      state.favoriteProductIds,
    );

    if (!favorites.add(productId)) {
      favorites.remove(productId);
    }

    emit(state.copyWith(
      favoriteProductIds: favorites,
    ));
  }

  // Combinarea listelor de produse fara duplicate
  List<Product> _merge(
      List<Product> first,
      List<Product> second,
      ) {
    final Map<String, Product> products = {};

    for (final product in [...first, ...second]) {
      products[product.id] = product;
    }

    return products.values.toList();
  }

  // Aplicarea cautarii, filtrarii si sortarii
  void _refreshProducts({
    String? searchQuery,
    SortOption? sortOption,
    FilterOption? filterOption,
  }) {
    final currentSearch =
        searchQuery ?? state.searchQuery;

    final currentSort =
        sortOption ?? state.sortOption;

    final currentFilter =
        filterOption ?? state.filterOption;

    final query = currentSearch.toLowerCase().trim();

    // Cautarea dupa denumirea produsului
    List<Product> products = _merge(
      state.featureProducts,
      state.recommendedProducts,
    ).where((product) {
      return query.isEmpty ||
          product.name.toLowerCase().contains(query);
    }).toList();

    // Filtrarea dupa pret
    switch (currentFilter) {
      case FilterOption.all:
        break;

      case FilterOption.under40:
        products = products
            .where((product) => product.price < 40)
            .toList();
        break;

      case FilterOption.from40To70:
        products = products
            .where((product) =>
        product.price >= 40 &&
            product.price <= 70)
            .toList();
        break;

      case FilterOption.over70:
        products = products
            .where((product) => product.price > 70)
            .toList();
        break;
    }

    // Sortarea produselor
    switch (currentSort) {
      case SortOption.none:
        break;

      case SortOption.priceLowToHigh:
        products.sort(
              (a, b) => a.price.compareTo(b.price),
        );
        break;

      case SortOption.priceHighToLow:
        products.sort(
              (a, b) => b.price.compareTo(a.price),
        );
        break;

      case SortOption.nameAtoZ:
        products.sort(
              (a, b) => a.name.compareTo(b.name),
        );
        break;
    }

    // Emiterea noii stari
    emit(state.copyWith(
      status: StoreStatus.success,
      searchQuery: currentSearch,
      sortOption: currentSort,
      filterOption: currentFilter,
      filteredProducts: products,
    ));
  }
}
