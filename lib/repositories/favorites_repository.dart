import 'package:shared_preferences/shared_preferences.dart';

/// Couche "données" : persiste les favoris localement avec shared_preferences.
class FavoritesRepository {
  static const _key = 'favorite_product_ids';

  Future<Set<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_key) ?? [];
    return saved.map(int.parse).toSet();
  }

  Future<void> saveFavorites(Set<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids.map((id) => id.toString()).toList());
  }
}
