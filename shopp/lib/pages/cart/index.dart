import 'dart:developer';

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
    final bool canOrder = cartProvider.totalPrice > 0;

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
                        color: theme.primaryTextTheme.titleLarge?.color),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  OrderButton(canOrder: canOrder)
                ]),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return CartItemWidget(
                cartItem: cartProvider.items.values.toList()[index]);
          },
          itemCount: cartProvider.itemCount,
        ))
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.canOrder,
  }) : super(key: key);

  final bool canOrder;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final bool canOrder = cartProvider.totalPrice > 0 || _isLoading;

    void placeOrder() async {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<OrderProvider>(context, listen: false).placeOrder(
            cartProvider.items.values.toList(), cartProvider.totalPrice);
        cartProvider.clear();
      } catch (err) {
        log(err.toString());
      }
      setState(() {
        _isLoading = false;
      });
    }

    return TextButton(
        onPressed: canOrder ? placeOrder : null,
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text('ORDER'));
  }
}
