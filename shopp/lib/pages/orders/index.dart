import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/providers/order.provider.dart';
import 'package:shopp/widgets/common/app_drawer.dart';
import 'package:shopp/widgets/common/loading.dart';
import 'package:shopp/widgets/pages/orders/order_item.dart';

class PageOrders extends StatefulWidget {
  static const route = '/orders';

  const PageOrders({super.key});

  @override
  State<PageOrders> createState() => _PageOrdersState();
}

class _PageOrdersState extends State<PageOrders> {
  Future? _ordersFuture;

  Future _getOrderFutureInstance() {
    return Provider.of<OrderProvider>(context, listen: false).fetch();
  }
  // bool _isLoading = false;

  @override
  void initState() {
    _ordersFuture = _getOrderFutureInstance(); // Create only 1 future
    // initPageData();
    super.initState();
  }

  // void initPageData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await Provider.of<OrderProvider>(context, listen: false).fetch();
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Your orders')),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: _ordersFuture,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else {
                if (snapshot.error != null) {
                  log(snapshot.error.toString());
                }
                return Consumer<OrderProvider>(
                    builder: (context, orderProvider, child) =>
                        ListView.builder(
                            itemBuilder: (context, index) {
                              return OrderItem(
                                order: orderProvider.orders[index],
                              );
                            },
                            itemCount: orderProvider.orders.length));
              }
            })));
  }
}
