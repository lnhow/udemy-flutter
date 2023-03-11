import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/pages/index.dart';
import 'package:shopp/pages/orders/index.dart';
import 'package:shopp/pages/manage/index.dart';
import 'package:shopp/providers/auth.provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static List<Map<String, Object>> drawerItems = [
    {'icon': Icons.shop, 'title': 'Home', 'to': PageIndex.route},
    {'icon': Icons.payment, 'title': 'My Order', 'to': PageOrders.route},
    {
      'icon': Icons.payment,
      'title': 'Manage Products',
      'to': PageManageProduct.route
    },
    // {
    //   'icon': Icons.exit_to_app,
    //   'title': 'Logout',
    //   'onTap': (BuildContext context) {
    //     Provider.of<AuthProvider>(context).logout();
    //   }
    // }
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
        ...drawerItems.map((e) {
          final VoidCallback onTap = (() {
            Navigator.of(context).pushReplacementNamed(e['to'] as String);
          });
          return Column(
            children: [
              const Divider(),
              ListTile(
                leading: Icon(e['icon'] as IconData),
                title: Text(e['title'] as String),
                onTap: onTap,
              )
            ],
          );
        }).toList(),
        Column(
          children: [
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            )
          ],
        )
      ],
    ));
  }
}
