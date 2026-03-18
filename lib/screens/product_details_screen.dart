import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/shop_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ShopProvider>();

    double price = double.parse(product.price);

    // bug 10
    // price only
    double finalPrice = price;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(product.imageUrl),

          const SizedBox(height: 12),

          Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text("Original Price: ${product.price} LE"),

          const SizedBox(height: 10),

          Text(
            "Final Price: $finalPrice LE",
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              provider.addToCart(product);
            },
            child: const Text("Add To Cart"),
          ),
        ],
      ),
    );
  }
}
