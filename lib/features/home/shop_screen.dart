import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {"name": "Cute Sticker Pack", "price": "₺20"},
      {"name": "Vintage Envelope", "price": "₺15"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Penpal Shop")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: Text(item["name"]!),
            subtitle: Text(item["price"]!),
            trailing: ElevatedButton(
              onPressed: () {
                // TODO: handle purchase
              },
              child: const Text("Buy"),
            ),
          );
        },
      ),
    );
  }
}
