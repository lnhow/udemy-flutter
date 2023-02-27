import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/cart.provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemData cartItem;

  const CartItemWidget({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<CartProvider>(context, listen: false).removeFromCart(cartItem.id);
      },
      confirmDismiss: ((direction) {
        return showDialog(context: context, builder: (ctx) {
          return AlertDialog(title: const Text('Confirm remove'), content: const Text('Are you sure you want to remove this item from cart?'),actions: [
            TextButton(child: const Text('Yes'), onPressed: () {
              Navigator.of(ctx).pop(true);
            }),
            TextButton(child: const Text('No'), onPressed: () {
              Navigator.of(ctx).pop(false);
            }),
          ],);
        });
      }),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(
                        child: Text(cartItem.price.toStringAsFixed(2))))),
            title: Text(cartItem.title),
            subtitle:
                Text('x ${cartItem.quantity} = ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
