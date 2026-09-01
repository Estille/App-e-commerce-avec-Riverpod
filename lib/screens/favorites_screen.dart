import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/product_providers.dart';
import '../providers/favorites_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/async_value_widget.dart';
import '../widgets/empty_state.dart';
import 'product_detail_screen.dart';

/// Écran 4 : favoris persistés (croisement productsProvider + favoritesProvider).
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    final favoriteIds = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: AsyncValueWidget<List<Product>>(
        value: productsAsync,
        onRetry: () => ref.invalidate(productsProvider),
        data: (products) {
          final favorites = products.where((p) => favoriteIds.contains(p.id)).toList();
          if (favorites.isEmpty) {
            return const EmptyState(message: 'Aucun favori pour le moment.', icon: Icons.favorite_border);
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.68,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return ProductCard(
                product: product,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
