import 'package:flutter/material.dart';
import 'package:places/pages/places/add.dart';
import 'package:places/widgets/loading.dart';

class PagePlacesList extends StatelessWidget {
  static const route = '/places';
  const PagePlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PagePlaceAdd.route);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: const Loading(),
    );
  }
}
