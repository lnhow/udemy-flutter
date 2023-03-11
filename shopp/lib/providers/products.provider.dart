import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shopp/providers/auth.provider.dart';
import 'package:shopp/providers/product.provider.dart';
import 'package:shopp/types/exception/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shopp/types/http.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   image:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   image:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   image: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   image:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  AuthProvider? authProvider;

  ProductsProvider({this.authProvider, ProductsProvider? productProvider}) {
    if (productProvider != null) {
      _products = productProvider._products;
    }
  }

  String? get authToken {
    return authProvider?.token;
  }

  List<Product> get products {
    return [..._products];
  }

  List<Product> get productsFavourite {
    return _products.where((product) => product.isFavorite).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  Future<void> add(Product product) async {
    try {
      final res = await http.post(toUrl('/products.json', auth: authToken),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'image': product.image,
            'isFavorite': product.isFavorite,
            'createdBy': authProvider?.uid,
          }));
      final resBody = json.decode(res.body);
      final newProduct = product.copyWith(id: resBody['name']);
      _products.add(newProduct);
      notifyListeners();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  Future<void> update(String id, Product product) async {
    final productIndexToUpdate =
        _products.indexWhere((element) => element.id == id);
    if (productIndexToUpdate < 0) {
      return;
    }
    final updateProduct = product.copyWith(id: id);
    try {
      await http.patch(toUrl('/products/$id.json', auth: authToken),
          body: json.encode({
            'title': updateProduct.title,
            'description': updateProduct.description,
            'price': updateProduct.price,
            'image': updateProduct.image,
            'isFavorite': updateProduct.isFavorite,
          }));
      _products[productIndexToUpdate] = updateProduct;
      notifyListeners();
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> delete(String id) async {
    final productIndex = _products.indexWhere((element) => element.id == id);
    final productToRemove = _products[productIndex];
    _products.removeAt(productIndex);
    notifyListeners();
    try {
      final res =
          await http.delete(toUrl('/products/$id.json', auth: authToken));
      if (res.statusCode >= 400) {
        throw HttpException(res.statusCode);
      }
    } catch (err) {
      _products.insert(productIndex, productToRemove);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchProducts({bool selfCreated = false}) async {
    final query = selfCreated
        ? {'orderBy': 'creatorId', 'equalTo': authProvider?.uid}
        : <String, dynamic>{};
    try {
      final allRes = await Future.wait([
        http.get(toUrl('/products.json', auth: authToken, query: query)),
        http.get(toUrl('/product-favorites/${authProvider?.uid}.json',
            auth: authToken))
      ]);

      final resProducts = json.decode(allRes[0].body) ?? {};
      final resFavorites = json.decode(allRes[1].body) ?? {};
      _products.clear();
      final List<Product> list = resProducts.keys
          .fold<List<Product>>(<Product>[], (List<Product> acc, id) {
        final value = resProducts[id];
        final isFavorite = resFavorites[id] ?? false;
        acc.add(Product(
            id: id,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            image: value['image'],
            isFavorite: isFavorite));
        return acc;
      });
      _products.addAll(list);
      notifyListeners();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }
}
