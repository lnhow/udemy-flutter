import 'package:flutter/material.dart';
import 'package:shopp/widgets/common/loading.dart';

class PageLoading extends StatelessWidget {
  static const route = '/loading';

  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // print('page loading');
    return const Scaffold(
      body: Loading(),
    );
  }
}
