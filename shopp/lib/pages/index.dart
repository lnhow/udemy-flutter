import 'package:flutter/material.dart';
import 'package:shopp/widgets/pages/index/products_list.dart';

class PageIndex extends StatelessWidget {
  const PageIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('shoplee'),
      ),
      body: const ProductList()
    );
  }
}
