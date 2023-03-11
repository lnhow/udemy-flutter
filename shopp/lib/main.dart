import 'package:flutter/material.dart';
import 'package:shopp/pages/auth/index.dart';
import 'package:shopp/pages/cart/index.dart';
import 'package:shopp/pages/index.dart';
import 'package:shopp/pages/manage/_id.dart';
import 'package:shopp/pages/manage/index.dart';
import 'package:shopp/pages/orders/index.dart';
import 'package:shopp/pages/products/_id.dart';

import 'package:provider/provider.dart';
import 'package:shopp/providers/auth.provider.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:shopp/providers/order.provider.dart';
import 'package:shopp/providers/products.provider.dart';

void main() {
  runApp(const MyApp());
}

final appRoutes = {
  PageIndex.route: (_) => const PageIndex(),
  PageProductDetail.route: (_) => const PageProductDetail(),
  PageCart.route: (_) => const PageCart(),
  PageOrders.route: (_) => const PageOrders(),
  PageManageProduct.route: (_) => const PageManageProduct(),
  PageEditProducts.route: (_) => const PageEditProducts(),
  PageAuth.route: (_) => const PageAuth(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return AuthProvider();
          }),
          ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
              update: (context, authProvider, prev) {
            return ProductsProvider(authProvider: authProvider);
          }, create: (context) {
            return ProductsProvider();
          }),
          ChangeNotifierProvider(create: (context) {
            return CartProvider();
          }),
          ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
              update: (context, authProvider, prev) {
            return OrderProvider(authProvider: authProvider);
          }, create: (context) {
            return OrderProvider();
          }),
        ],
        child: Consumer<AuthProvider>(
          builder: (ctx, authProvider, child) => MaterialApp(
            title: 'shoplee',
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.green,
                accentColor: Colors.greenAccent,
              ),
            ),
            home: authProvider.isAuth ? const PageIndex() : const PageAuth(),
            routes: appRoutes,
          ),
        ));
  }
}
