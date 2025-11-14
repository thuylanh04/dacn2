// Provider: Categories list

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import 'repository_providers.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.read(categoryRepositoryProvider);
  return repo.getCategories();
});
