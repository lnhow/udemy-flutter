import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/order.provider.dart';
import 'package:shopp/widgets/common/app_drawer.dart';
import 'package:shopp/widgets/pages/orders/order_item.dart';

class PageOrders extends StatelessWidget {
  static const route = '/orders';

  const PageOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Your orders')),
        drawer: const AppDrawer(),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return OrderItem(order: orderProvider.orders[index],);
            },
            itemCount: orderProvider.orders.length));
  }
}
