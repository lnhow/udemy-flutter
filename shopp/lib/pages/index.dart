import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/pages/cart/index.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:shopp/widgets/common/app_drawer.dart';
import 'package:shopp/widgets/common/badge.dart';

import 'package:shopp/widgets/pages/index/products_list.dart';
import 'package:shopp/types/filter.dart';

const filters = {
  FilterOptions.all: 'All',
  FilterOptions.favourites: 'Favourites',
};

class PageIndex extends StatefulWidget {
  static const route = '/';

  const PageIndex({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PageIndexState();
  }
}

class _PageIndexState extends State<PageIndex> {
  FilterOptions _filter = FilterOptions.all;

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
      body: ProductList(filter: _filter),
    );
  }
}
