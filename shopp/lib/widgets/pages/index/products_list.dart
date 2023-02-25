import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/products.provider.dart';
import 'package:shopp/types/filter.dart';
import 'package:shopp/widgets/pages/index/product_box.dart';

class ProductList extends StatelessWidget {
  final FilterOptions filter;

  const ProductList({required this.filter,super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = (filter == FilterOptions.favourites) ? productsProvider.productsFavourite : productsProvider.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider.value(
            value: products[index], child: const ProductBox());
      },
    );
  }
}
