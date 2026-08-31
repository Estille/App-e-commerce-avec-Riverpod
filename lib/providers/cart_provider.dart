import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

/// Logique métier du panier (StateNotifier = couche "logique", pas de widget ici).
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addProduct(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      final updated = [...state];
      updated[index] = updated[index].copyWith(quantity: updated[index].quantity + 1);
      state = updated;
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeProduct(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }
    state = [
      for (final item in state)
        if (item.product.id == productId) item.copyWith(quantity: quantity) else item
    ];
  }

  void clear() {
    state = [];
  }
}

/// StateNotifierProvider : état du panier (liste des articles).
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

/// Provider dérivé : nombre total d'articles (toutes quantités confondues).
final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold<int>(0, (sum, item) => sum + item.quantity);
});

/// Provider dérivé : total du panier en euros.
final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).fold<double>(0.0, (sum, item) => sum + item.subtotal);
});
