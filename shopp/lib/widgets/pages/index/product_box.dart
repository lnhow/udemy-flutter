import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/product.provider.dart';
import 'package:shopp/pages/products/_id.dart';

class ProductBox extends StatelessWidget {
  static const route = '/';
  // final Product product;

  const ProductBox({super.key});

  void navigateToProductDetail(context, id) {
    Navigator.of(context).pushNamed(PageProductDetail.route, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final product = Provider.of<Product>(context);

    return Consumer<Product>(
      builder: (context, product, child) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              leading: IconButton(
                icon: product.isFavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                color: product.isFavorite
                    ? theme.colorScheme.error
                    : theme.colorScheme.surface,
                onPressed: (() {
                  product.toggleFavourite();
                }),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: theme.colorScheme.secondary,
                onPressed: (() {}),
              ),
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black54,
            ),
            child: GestureDetector(
                onTap: () => navigateToProductDetail(context, product.id),
                child: Image.network(product.image, fit: BoxFit.cover)),
          )),
    );
  }
}
