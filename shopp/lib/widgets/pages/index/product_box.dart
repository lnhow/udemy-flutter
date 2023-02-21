import 'package:flutter/material.dart';
import 'package:shopp/models/product.dart';

class ProductBox extends StatelessWidget {
  final Product product;

  const ProductBox({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: (() {}),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: (() {}),
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
      ),
      child: Image.network(product.image, fit: BoxFit.cover),
    );
  }
}
