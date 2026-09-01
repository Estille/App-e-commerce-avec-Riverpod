import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/product_providers.dart';
import '../providers/sort_option.dart';
import '../widgets/product_card.dart';
import '../widgets/async_value_widget.dart';
import '../widgets/empty_state.dart';
import 'product_detail_screen.dart';

/// Écran 1 : catalogue avec recherche, filtre par catégorie et tri.
class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAsync = ref.watch(filteredProductsProvider);
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(categoryFilterProvider);
    final sortOption = ref.watch(sortOptionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(labelText: 'Catégorie'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Toutes')),
                      ...categories.map((c) => DropdownMenuItem(value: c, child: Text(c))),
                    ],
                    onChanged: (value) => ref.read(categoryFilterProvider.notifier).state = value,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<SortOption>(
                    initialValue: sortOption,
                    decoration: const InputDecoration(labelText: 'Trier par'),
                    items: const [
                      DropdownMenuItem(value: SortOption.nameAsc, child: Text('Nom (A-Z)')),
                      DropdownMenuItem(value: SortOption.priceAsc, child: Text('Prix croissant')),
                      DropdownMenuItem(value: SortOption.priceDesc, child: Text('Prix décroissant')),
                      DropdownMenuItem(value: SortOption.ratingDesc, child: Text('Meilleures notes')),
                    ],
                    onChanged: (value) {
                      if (value != null) ref.read(sortOptionProvider.notifier).state = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: AsyncValueWidget<List<Product>>(
              value: filteredAsync,
              onRetry: () => ref.invalidate(productsProvider),
              data: (products) {
                if (products.isEmpty) {
                  return const EmptyState(message: 'Aucun produit ne correspond à ta recherche.');
                }
                return RefreshIndicator(
                  onRefresh: () => ref.refresh(productsProvider.future),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
