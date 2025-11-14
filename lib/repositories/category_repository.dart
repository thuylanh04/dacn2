// Repository: CategoryRepository
// Abstracts ApiService for categories.

import '../models/category.dart';
import '../services/api_service.dart';

class CategoryRepository {
  final ApiService _api;
  CategoryRepository(this._api);

  Future<List<Category>> getCategories() => _api.getCategories();
}
