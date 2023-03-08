import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/pages/manage/_id.dart';
import 'package:shopp/providers/products.provider.dart';
import 'package:shopp/widgets/common/app_drawer.dart';
import 'package:shopp/widgets/pages/manage/user_product_item.dart';

class PageManageProduct extends StatelessWidget {
  static const route = '/manage/products';

  const PageManageProduct({super.key});

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final products = productProvider.products;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PageEditProducts.route);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemBuilder: (_, i) {
                return UserProductItem(product: products[i]);
              },
              itemCount: products.length,
            ),
          ),
        ));
  }
}
