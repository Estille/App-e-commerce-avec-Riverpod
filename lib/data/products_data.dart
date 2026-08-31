import '../models/product.dart';

/// Données mockées (aucune donnée en dur dans les widgets/écrans).
class ProductsData {
  static final List<Product> products = [
    Product(id: 1, name: 'T-shirt coton bio', description: "T-shirt unisexe 100% coton bio, coupe classique, disponible en plusieurs couleurs.", price: 19.99, category: 'Vêtements', rating: 4.3, stock: 12),
    Product(id: 2, name: 'Casque audio sans fil', description: "Casque Bluetooth à réduction de bruit active, autonomie de 30 heures.", price: 59.99, category: 'Électronique', rating: 4.6, stock: 5),
    Product(id: 3, name: 'Lampe de bureau LED', description: "Lampe LED à intensité réglable avec port USB intégré pour recharger vos appareils.", price: 24.50, category: 'Maison', rating: 4.1, stock: 8),
    Product(id: 4, name: 'Ballon de football', description: "Ballon officiel taille 5, résistant à l'eau, idéal pour un usage intensif.", price: 15.00, category: 'Sport', rating: 4.4, stock: 20),
    Product(id: 5, name: 'Crème hydratante visage', description: "Crème hydratante 24h à base d'acide hyaluronique, pour tous types de peau.", price: 12.90, category: 'Beauté', rating: 4.0, stock: 15),
    Product(id: 6, name: 'Montre connectée', description: "Montre connectée avec suivi du rythme cardiaque, du sommeil et des activités sportives.", price: 89.99, category: 'Électronique', rating: 4.5, stock: 3),
    Product(id: 7, name: 'Jean slim', description: "Jean coupe slim, tissu extensible pour un confort optimal toute la journée.", price: 39.99, category: 'Vêtements', rating: 3.9, stock: 10),
    Product(id: 8, name: 'Tapis de yoga', description: "Tapis antidérapant 6mm, idéal pour le yoga, le pilates et les étirements.", price: 22.00, category: 'Sport', rating: 4.2, stock: 0),
    Product(id: 9, name: 'Coussin décoratif', description: "Coussin décoratif en velours, housse déhoussable et lavable en machine.", price: 14.90, category: 'Maison', rating: 3.8, stock: 25),
    Product(id: 10, name: 'Parfum floral', description: "Eau de parfum aux notes florales et boisées, tenue longue durée.", price: 34.90, category: 'Beauté', rating: 4.7, stock: 6),
  ];
}
