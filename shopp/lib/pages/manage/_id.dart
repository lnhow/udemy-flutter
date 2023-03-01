import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/products.provider.dart';
import 'package:shopp/widgets/common/app_drawer.dart';
import 'package:shopp/widgets/pages/manage/user_product_item.dart';

class PageEditProducts extends StatefulWidget {
  static const route = '/manage/product/_id';

  const PageEditProducts({super.key});

  @override
  State<PageEditProducts> createState() => _PageEditProductsState();
}

class _PageEditProductsState extends State<PageEditProducts> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final products = productProvider.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
              child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              )
            ],
          ))),
    );
  }
}
