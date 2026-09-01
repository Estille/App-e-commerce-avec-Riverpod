import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/providers/cart_provider.dart';
import 'package:riverpod_app/models/product.dart';

/// Ces tests montrent que la logique du panier (CartNotifier) fonctionne
/// indépendamment de tout widget : c'est la preuve de la séparation
/// UI / logique métier demandée dans l'architecture en couches.
void main() {
  const product = Product(
    id: 1,
    name: 'Produit test',
    description: 'Description test',
    price: 10.0,
    category: 'Test',
    rating: 4.0,
    stock: 5,
  );

  test('addProduct ajoute un nouvel article au panier', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(cartProvider.notifier).addProduct(product);

    expect(container.read(cartProvider).length, 1);
    expect(container.read(cartProvider).first.quantity, 1);
  });

  test('addProduct incrémente la quantité si le produit est déjà présent', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(cartProvider.notifier).addProduct(product);
    container.read(cartProvider.notifier).addProduct(product);

    expect(container.read(cartProvider).length, 1);
    expect(container.read(cartProvider).first.quantity, 2);
  });

  test('removeProduct retire un article du panier', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(cartProvider.notifier).addProduct(product);
    container.read(cartProvider.notifier).removeProduct(product.id);

    expect(container.read(cartProvider), isEmpty);
  });

  test('updateQuantity à 0 retire le produit du panier', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(cartProvider.notifier).addProduct(product);
    container.read(cartProvider.notifier).updateQuantity(product.id, 0);

    expect(container.read(cartProvider), isEmpty);
  });

  test('cartTotalProvider calcule correctement le total', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(cartProvider.notifier).addProduct(product);
    container.read(cartProvider.notifier).updateQuantity(product.id, 3);

    expect(container.read(cartTotalProvider), 30.0);
  });

  test('cartItemCountProvider compte toutes les quantités', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    const otherProduct = Product(
      id: 2,
      name: 'Autre produit',
      description: 'Description',
      price: 5.0,
      category: 'Test',
      rating: 3.5,
      stock: 2,
    );

    container.read(cartProvider.notifier).addProduct(product);
    container.read(cartProvider.notifier).updateQuantity(product.id, 2);
    container.read(cartProvider.notifier).addProduct(otherProduct);

    expect(container.read(cartItemCountProvider), 3);
  });
}
