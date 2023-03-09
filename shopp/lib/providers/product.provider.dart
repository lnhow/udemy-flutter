import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopp/types/exception/http_exception.dart';
import 'package:shopp/types/http.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      this.isFavorite = false});

  void _setFavorite(bool val) {
    isFavorite = val;
    notifyListeners();
  }

  Future<void> toggleFavourite() async {
    final currentState = isFavorite;
    _setFavorite(!isFavorite);
    try {
      final res = await http.patch(toUrl('/products/$id.json'),
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (res.statusCode >= 400) {
        throw HttpException(res.statusCode);
      }
    } catch (err) {
      _setFavorite(currentState);
    }
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? image,
  }) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image);
  }
}
