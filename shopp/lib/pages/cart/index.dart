import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:shopp/providers/order.provider.dart';
import 'package:shopp/widgets/pages/cart/cart_item.dart';

class PageCart extends StatelessWidget {
  static const route = '/cart';
  const PageCart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartProvider = Provider.of<CartProvider>(context);

    void placeOrder() {
      Provider.of<OrderProvider>(context, listen: false).placeOrder(cartProvider.items.values.toList(), cartProvider.totalPrice);
      cartProvider.clear();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(cartProvider.totalPrice.toStringAsFixed(2)),
                    labelStyle: TextStyle(
                        color: theme.primaryTextTheme.headline6?.color),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  TextButton(onPressed: placeOrder, child: const Text('ORDER'))
                ]),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return CartItemWidget(cartItem: cartProvider.items.values.toList()[index]);
          },
          itemCount: cartProvider.itemCount,
        ))
      ]),
    );
  }
}
