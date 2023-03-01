import 'package:flutter/material.dart';
import 'package:shopp/providers/product.provider.dart';

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
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
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
