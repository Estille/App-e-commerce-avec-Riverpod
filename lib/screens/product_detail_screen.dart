import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/rating_badge.dart';

/// Écran 2 : détail d'un produit (reçu directement via le constructeur).
class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () => ref.read(favoritesProvider.notifier).toggleFavorite(product.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Center(child: Icon(Icons.shopping_bag, size: 80, color: Theme.of(context).colorScheme.primary)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  RatingBadge(rating: product.rating),
                  const SizedBox(height: 12),
                  Text(
                    '${product.price.toStringAsFixed(2)} €',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('Catégorie : ${product.category}', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    product.stock > 0 ? 'En stock (${product.stock} restants)' : 'Rupture de stock',
                    style: TextStyle(color: product.stock > 0 ? Colors.green : Colors.red, fontWeight: FontWeight.w600),
                  ),
                  const Divider(height: 32),
                  Text('Description', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(product.description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: product.stock > 0
                ? () {
                    ref.read(cartProvider.notifier).addProduct(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} ajouté au panier')),
                    );
                  }
                : null,
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Ajouter au panier'),
          ),
        ),
      ),
    );
  }
}
