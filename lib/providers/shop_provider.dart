import 'package:flutter/foundation.dart';

import '../models/product.dart';

class ShopProvider with ChangeNotifier {
  // bug 11 is one to 0.14 not 14
  static const double vatRate = 0.14;

  List<Product> products = [
    const Product(
      id: 'p1',
      title: 'كاميرا احترافية',
      price: 23000,
      imageUrl: 'https://picsum.photos/seed/p1/400/300',
      description: 'كاميرا بدقة عالية مناسبة للتصوير.',
    ),
    const Product(
      id: 'p2',
      title: 'لابتوب 14 بوصة',
      price: 44500,
      imageUrl: 'https://picsum.photos/seed/p2/400/300',
      description: 'لابتوب أداء قوي.',
    ),
  ];

  List<Product> cart = [];
  double total = 0;

  Product byId(String id) {
    return products.firstWhere((p) => p.id == id);
  }

  void addToCart(Product product) {
    if (!cart.any((p) => p.id == product.id)) {
      cart.add(product);
    }
    // bug 12 calcolechan to prodact 
    notifyListeners();
    recalculateTotal();
  }

  void removeFromCart(Product product) {
    cart.remove(product);

    recalculateTotal();

    notifyListeners();
  }

  double calculateFinalPrice(Product product) {
    double price = (product.price);
  // bug 13 check calculation order
    if(price >1000){
    price += price * 0.14; 
    }
    if (price > 10000) {
      price -= price * 0.10;
    }

    return price; 
  }

  void recalculateTotal() {
    total = 0;

    for (var item in cart) {
      total += calculateFinalPrice(item);
    }

    total = double.parse(total.toStringAsFixed(2));
  }
}
