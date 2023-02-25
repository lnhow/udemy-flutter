import 'package:flutter/material.dart';
import 'package:shopp/pages/cart/index.dart';
import 'package:shopp/pages/index.dart';
import 'package:shopp/pages/orders/index.dart';
import 'package:shopp/pages/products/_id.dart';

import 'package:provider/provider.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:shopp/providers/order.provider.dart';
import 'package:shopp/providers/products.provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return ProductsProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return CartProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return OrderProvider();
        }),
      ],
      child: MaterialApp(
        title: 'shoplee',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
            accentColor: Colors.greenAccent,
          ),
        ),
        routes: {
          '/': (_) => const PageIndex(),
          PageProductDetail.route: (_) => const PageProductDetail(),
          PageCart.route: (_) => const PageCart(),
          PageOrders.route: (_) => const PageOrders(),
        },
      ),
    );
  }
}
