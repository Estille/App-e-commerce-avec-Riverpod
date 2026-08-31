import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repositories/favorites_repository.dart';

/// Logique métier des favoris, avec persistance via FavoritesRepository.
class FavoritesNotifier extends StateNotifier<Set<int>> {
  final FavoritesRepository _repository;

  FavoritesNotifier(this._repository) : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final saved = await _repository.loadFavorites();
    state = saved;
  }

  void toggleFavorite(int productId) {
    final updated = {...state};
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }
    state = updated;
    _repository.saveFavorites(updated);
  }
}

/// Provider : instance du repository de favoris (persistance locale).
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository();
});

/// StateNotifierProvider : ensemble des ids de produits favoris (persisté sur disque).
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<int>>((ref) {
  return FavoritesNotifier(ref.watch(favoritesRepositoryProvider));
});
