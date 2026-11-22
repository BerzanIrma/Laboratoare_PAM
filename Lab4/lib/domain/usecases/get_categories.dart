import '../entities/category.dart';
import '../repositories/store_repository.dart';

class GetCategories {
  final StoreRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call() {
    return repository.getCategories();
  }
}