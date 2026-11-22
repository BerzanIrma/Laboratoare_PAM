
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/store_remote_data_source.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource remoteDataSource;

  StoreRepositoryImpl({
    required this.remoteDataSource,
  });

  // Preluarea categoriilor din API
  @override
  Future<List<Category>> getCategories() async {
    final data = await remoteDataSource.getFeed();
    final items = data['categories'] as List;

    return items
        .map(
          (item) => Category.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  // Preluarea produselor recomandate pentru secțiunea Featured
  @override
  Future<List<Product>> getFeatureProducts() async {
    final data = await remoteDataSource.getFeed();
    final items = data['featureProducts'] as List;

    return items
        .map(
          (item) => Product.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  // Preluarea produselor din secțiunea Recommended
  @override
  Future<List<Product>> getRecommendedProducts() async {
    final data = await remoteDataSource.getFeed();
    final items = data['recommended'] as List;

    return items
        .map(
          (item) => Product.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  // Preluarea produsului din pagina de detalii
  @override
  Future<Product> getProduct() async {
    final data = await remoteDataSource.getProductDetails();
    final product = Map<String, dynamic>.from(data['product']);

    return Product.fromJson(product);
  }

  // Preluarea recenziilor produsului
  @override
  Future<List<Review>> getReviews() async {
    final data = await remoteDataSource.getProductDetails();
    final product = data['product'] as Map;
    final items = product['reviews'] as List;

    return items
        .map(
          (item) => Review.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  // Preluarea produselor similare
  @override
  Future<List<Product>> getSimilarProducts() async {
    final data = await remoteDataSource.getProductDetails();
    final product = data['product'] as Map;
    final items = product['similarProducts'] as List;

    return items
        .map(
          (item) => Product.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  // Datele complete pentru Home Page
  @override
  Future<Map<String, dynamic>> getHomePageData() async {
    return await remoteDataSource.getFeed();
  }

  // Datele complete pentru Product Page
  @override
  Future<Map<String, dynamic>> getProductPageData() async {
    return await remoteDataSource.getProductDetails();
  }
}
