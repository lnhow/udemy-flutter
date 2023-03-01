import 'package:flutter/material.dart';
import 'package:shopp/pages/index.dart';
import 'package:shopp/pages/orders/index.dart';
import 'package:shopp/pages/manage/index.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const List<Map<String, Object>> drawerItems = [
    {'icon': Icons.shop, 'title': 'Home', 'to': PageIndex.route},
    {'icon': Icons.payment, 'title': 'My Order', 'to': PageOrders.route},
    {'icon': Icons.payment, 'title': 'Manage Products', 'to': PageManageProduct.route},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: const Text('Welcome'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ...drawerItems.map((e) => ListTile(
          leading: Icon(e['icon'] as IconData),
          title: Text(e['title'] as String),
          onTap: (() {
            Navigator.of(context).pushReplacementNamed(e['to'] as String);
          }),
        )).toList()
      ],
    ));
  }
}
