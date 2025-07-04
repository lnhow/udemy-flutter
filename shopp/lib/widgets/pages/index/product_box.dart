import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/auth.provider.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:shopp/providers/product.provider.dart';
import 'package:shopp/pages/products/_id.dart';

class ProductBox extends StatelessWidget {
  static const route = '/';
  // final Product product;

  const ProductBox({super.key});

  void navigateToProductDetail(context, id) {
    Navigator.of(context).pushNamed(PageProductDetail.route, arguments: id);
  }

  void handleAddToCart(context, cartProvider, product) {
    cartProvider.addToCart(product);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Added item to cart!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: (() {
            cartProvider.removeSingleItemFromCart(product.id);
          }),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

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
                  product.toggleFavourite(authProvider);
                }),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: (() {
                  handleAddToCart(context, cartProvider, product);
                }),
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
