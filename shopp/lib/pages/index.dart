import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';
import 'package:shopp/pages/cart/index.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:shopp/providers/products.provider.dart';
import 'package:shopp/widgets/common/app_drawer.dart';
import 'package:shopp/widgets/common/badge.dart';
import 'package:shopp/widgets/common/loading.dart';

import 'package:shopp/widgets/pages/index/products_list.dart';
import 'package:shopp/types/filter.dart';

const filters = {
  FilterOptions.all: 'All',
  FilterOptions.favourites: 'Favourites',
};

class PageIndex extends StatefulWidget {
  static const route = '/index';

  const PageIndex({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PageIndexState();
  }
}

class _PageIndexState extends State<PageIndex> {
  FilterOptions _filter = FilterOptions.all;
  bool _isLoading = false;

  @override
  void initState() {
    initProductData();
    super.initState();
  }

  void initProductData() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('shoplee'), actions: [
        PopupMenuButton(
            onSelected: (val) {
              setState(() {
                _filter = val;
              });
            },
            icon: const Icon(Icons.filter_list),
            itemBuilder: (_) => filters.entries
                .map((entry) => PopupMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    ))
                .toList()),
        Consumer<CartProvider>(
          builder: (context, cart, child) =>
              Badge(value: cart.itemCount.toString(), child: child!),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (() {
              Navigator.of(context).pushNamed(PageCart.route);
            }),
          ),
        ),
      ]),
      body: _isLoading ? const Loading() : ProductList(filter: _filter),
    );
  }
}
