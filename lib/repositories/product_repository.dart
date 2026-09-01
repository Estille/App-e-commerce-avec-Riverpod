import 'dart:math';
import '../models/product.dart';
import '../data/products_data.dart';

/// Couche "données" : simule un appel réseau (fake API).
class ProductRepository {
  /// [simulateFailures] : si true, l'appel échoue une fois sur 5 environ,
  /// pour pouvoir démontrer concrètement la gestion d'erreur dans l'UI
  /// (état error + bouton "Réessayer"). Mets false pour un comportement stable.
  final bool simulateFailures;

  ProductRepository({this.simulateFailures = true});

  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (simulateFailures && Random().nextInt(5) == 0) {
      throw Exception('Impossible de contacter le serveur, réessaie.');
    }
    return ProductsData.products;
  }
}
