import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';
import 'sort_option.dart';

/// Provider : instance du repository (couche données).
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

/// FutureProvider : charge les produits de façon asynchrone.
/// Expose automatiquement un AsyncValue`<List<Product>>` (loading/data/error).
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.fetchProducts();
});

/// StateProvider : catégorie sélectionnée pour le filtrage (null = toutes).
final categoryFilterProvider = StateProvider<String?>((ref) => null);

/// StateProvider : critère de tri sélectionné.
final sortOptionProvider = StateProvider<SortOption>((ref) => SortOption.nameAsc);

/// StateProvider : texte de recherche.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Provider dérivé : applique recherche + filtre + tri sur les produits chargés,
/// tout en conservant l'`AsyncValue` (via whenData) pour gérer loading/erreur dans l'UI.
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final category = ref.watch(categoryFilterProvider);
  final sort = ref.watch(sortOptionProvider);
  final query = ref.watch(searchQueryProvider);

  return productsAsync.whenData((products) {
    var result = products.where((p) {
      final matchesCategory = category == null || p.category == category;
      final matchesQuery = p.name.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    switch (sort) {
      case SortOption.nameAsc:
        result.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.priceAsc:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDesc:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.ratingDesc:
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return result;
  });
});

/// Provider dérivé : liste des catégories disponibles (à partir des produits chargés).
final categoriesProvider = Provider<List<String>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  return productsAsync.maybeWhen(
    data: (products) => (products.map((p) => p.category).toSet().toList()..sort()),
    orElse: () => [],
  );
});
