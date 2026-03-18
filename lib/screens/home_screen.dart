import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_exam/screens/product_details_screen.dart';
import 'package:shopping_exam/widgets/product_card.dart';

import '../providers/shop_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShopProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              // BUG 8
              //to string fixed an to string
              child: Text(provider.total.toStringAsFixed(2)),
            ),
          ),
        ],
      ),
      body: provider.products.isEmpty
          ? const Center(child: Text("No Products Available"))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: provider.products.length,
              itemBuilder: (_, i) {
                final p = provider.products[i];
                return ProductCard(
                  title: p.title,
                  price: "${p.price} LE",
                  imageUrl: p.imageUrl,
                  // BUG 9
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: p),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
