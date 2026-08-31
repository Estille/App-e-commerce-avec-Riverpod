import '../models/product.dart';
import '../data/products_data.dart';

/// Couche "données" : simule un appel réseau (fake API).
class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return ProductsData.products;
  }
}
