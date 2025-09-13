import 'package:flutter/material.dart';

/// Minimal placeholder view for the Products feature.
class ProductsPage extends StatelessWidget {
  /// Creates a ProductsPage.
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: const Center(child: Text('Products Feature')),
    );
  }
}
