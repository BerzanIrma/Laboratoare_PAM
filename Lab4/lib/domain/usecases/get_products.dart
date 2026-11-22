import '../entities/product.dart';
import '../repositories/store_repository.dart';

class GetProducts {
  final StoreRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> getFeatureProducts() {
    return repository.getFeatureProducts();
  }

  Future<List<Product>> getRecommendedProducts() {
    return repository.getRecommendedProducts();
  }
}