
import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';

enum StoreStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

enum SortOption {
  none,
  priceLowToHigh,
  priceHighToLow,
  nameAtoZ,
}

enum FilterOption {
  all,
  under40,
  from40To70,
  over70,
}

class StoreState {
  final StoreStatus status;

  final List<Category> categories;
  final String? selectedCategoryId;

  final List<Product> featureProducts;
  final List<Product> recommendedProducts;
  final List<Product> filteredProducts;

  final Map<String, dynamic> homePageData;
  final Map<String, dynamic> productPageData;

  final String searchQuery;
  final SortOption sortOption;
  final FilterOption filterOption;

  final Set<String> favoriteProductIds;
  final String? errorMessage;

  const StoreState({
    this.status = StoreStatus.initial,
    this.categories = const [],
    this.selectedCategoryId,
    this.featureProducts = const [],
    this.recommendedProducts = const [],
    this.filteredProducts = const [],
    this.homePageData = const {},
    this.productPageData = const {},
    this.searchQuery = '',
    this.sortOption = SortOption.none,
    this.filterOption = FilterOption.all,
    this.favoriteProductIds = const {},
    this.errorMessage,
  });

  bool get isFiltering =>
      searchQuery.trim().isNotEmpty ||
          filterOption != FilterOption.all ||
          sortOption != SortOption.none;

  bool isFavorite(String productId) =>
      favoriteProductIds.contains(productId);

  StoreState copyWith({
    StoreStatus? status,
    List<Category>? categories,
    String? selectedCategoryId,
    List<Product>? featureProducts,
    List<Product>? recommendedProducts,
    List<Product>? filteredProducts,
    Map<String, dynamic>? homePageData,
    Map<String, dynamic>? productPageData,
    String? searchQuery,
    SortOption? sortOption,
    FilterOption? filterOption,
    Set<String>? favoriteProductIds,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return StoreState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategoryId:
      selectedCategoryId ?? this.selectedCategoryId,
      featureProducts:
      featureProducts ?? this.featureProducts,
      recommendedProducts:
      recommendedProducts ?? this.recommendedProducts,
      filteredProducts:
      filteredProducts ?? this.filteredProducts,
      homePageData: homePageData ?? this.homePageData,
      productPageData: productPageData ?? this.productPageData,
      searchQuery: searchQuery ?? this.searchQuery,
      sortOption: sortOption ?? this.sortOption,
      filterOption: filterOption ?? this.filterOption,
      favoriteProductIds:
      favoriteProductIds ?? this.favoriteProductIds,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}
