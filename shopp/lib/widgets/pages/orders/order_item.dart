import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:shopp/providers/order.provider.dart';

class OrderItem extends StatefulWidget {
  final OrderData order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final List<CartItemData> cartItems = widget.order.cartItems;
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.total.toStringAsFixed(2)}'),
          subtitle: Text(
              DateFormat('hh:mm dd/MM/yyyy').format(widget.order.orderTime)),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: (() {
              setState(() {
                _expanded = !_expanded;
              });
            }),
          ),
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.all(10),
              height: min(cartItems.length * 20 + 30, 120),
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    final cartItemData = cartItems[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cartItemData.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '${cartItemData.quantity} x \$${cartItemData.price.toStringAsFixed(2)}'
                            ' = \$${(cartItemData.quantity * cartItemData.price).toStringAsFixed(2)}')
                      ],
                    );
                  },
                  itemCount: cartItems.length)),
      ]),
    );
  }
}
