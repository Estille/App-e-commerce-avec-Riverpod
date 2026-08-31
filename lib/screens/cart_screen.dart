import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/empty_state.dart';

/// Écran 3 : panier (ajout, suppression, quantité — géré via cartProvider).
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mon panier')),
      body: cartItems.isEmpty
          ? const EmptyState(message: 'Ton panier est vide.', icon: Icons.shopping_cart_outlined)
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                  title: Text(item.product.name),
                  subtitle: Text('${item.product.price.toStringAsFixed(2)} € × ${item.quantity} = ${item.subtotal.toStringAsFixed(2)} €'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QuantitySelector(
                        quantity: item.quantity,
                        onChanged: (qty) => ref.read(cartProvider.notifier).updateQuantity(item.product.id, qty),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => ref.read(cartProvider.notifier).removeProduct(item.product.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total : ${total.toStringAsFixed(2)} €',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Commande confirmée, merci !')),
                        );
                      },
                      child: const Text('Commander'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
