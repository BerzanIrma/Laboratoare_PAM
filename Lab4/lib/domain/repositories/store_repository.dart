import '../entities/category.dart';
import '../entities/product.dart';
import '../entities/review.dart';

abstract class StoreRepository {
  Future<List<Category>> getCategories();

  Future<List<Product>> getFeatureProducts();

  Future<List<Product>> getRecommendedProducts();

  Future<Product> getProduct();

  Future<List<Review>> getReviews();

  Future<List<Product>> getSimilarProducts();

  Future<Map<String, dynamic>> getHomePageData();

  Future<Map<String, dynamic>> getProductPageData();
}