import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';

/// Écran 5 : profil utilisateur (mock).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    final favoritesCount = ref.watch(favoritesProvider).length;
    final cartCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mon profil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: const Icon(Icons.person, size: 40),
          ),
          const SizedBox(height: 16),
          Center(child: Text(user.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
          Center(child: Text(user.email, style: Theme.of(context).textTheme.bodyMedium)),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(leading: const Icon(Icons.calendar_today), title: const Text('Membre depuis'), trailing: Text(user.memberSince)),
                const Divider(height: 1),
                ListTile(leading: const Icon(Icons.receipt_long), title: const Text('Commandes passées'), trailing: Text('${user.totalOrders}')),
                const Divider(height: 1),
                ListTile(leading: const Icon(Icons.favorite), title: const Text('Favoris'), trailing: Text('$favoritesCount')),
                const Divider(height: 1),
                ListTile(leading: const Icon(Icons.shopping_cart), title: const Text('Articles dans le panier'), trailing: Text('$cartCount')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
