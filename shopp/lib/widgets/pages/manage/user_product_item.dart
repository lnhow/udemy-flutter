import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/pages/manage/_id.dart';
import 'package:shopp/providers/product.provider.dart';
import 'package:shopp/providers/products.provider.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(product.title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.image),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.of(context).pushNamed(PageEditProducts.route, arguments: product.id);
                }, icon: const Icon(Icons.edit)),
                IconButton(
                  onPressed: () {
                    Provider.of<ProductsProvider>(context, listen: false).delete(product.id);
                  },
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
