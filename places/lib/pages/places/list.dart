import 'package:flutter/material.dart';
import 'package:places/widgets/loading.dart';

class PagePlacesList extends StatelessWidget {
  const PagePlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: const Loading(),
    );
  }
}
