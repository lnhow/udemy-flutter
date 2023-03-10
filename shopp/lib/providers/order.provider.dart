import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:shopp/providers/cart.provider.dart';
import 'package:http/http.dart' as http;
import 'package:shopp/types/exception/http_exception.dart';
import 'package:shopp/types/http.dart';

class OrderData {
  final String id;
  final double total;
  final List<CartItemData> cartItems;
  final DateTime orderTime;

  OrderData(
      {required this.id,
      required this.total,
      required this.cartItems,
      required this.orderTime});
}

class OrderProvider with ChangeNotifier {
  final List<OrderData> _orders = [];

  List<OrderData> get orders {
    return [..._orders];
  }

  Future<void> placeOrder(List<CartItemData> cartItems, double total) async {
    final now = DateTime.now();
    try {
      final res = await http.post(toUrl('/orders.json'),
          body: json.encode({
            'total': total,
            'orderTime': now.toIso8601String(),
            'cartItems': cartItems
                .map((item) => {
                      'id': item.id,
                      'title': item.title,
                      'price': double.parse(item.price.toStringAsFixed(2)),
                      'quantity': item.quantity,
                    })
                .toList()
          }));
      final resBody = json.decode(res.body);
      _orders.add(OrderData(
          id: resBody['name'],
          total: total,
          cartItems: cartItems,
          orderTime: now));
      notifyListeners();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  Future<void> fetch() async {
    try {
      final res = await http.get(toUrl('/orders.json'));
      var resBody = json.decode(res.body);
      if (resBody == null) {
        return;
      }
      resBody = resBody as Map<String, dynamic>;
      _orders.clear();
      
      final List<OrderData> list =
          resBody.keys.fold<List<OrderData>>([], (acc, id) {
        final value = resBody[id];
        acc.add(OrderData(
            id: id,
            total: value['total'],
            orderTime: DateTime.parse(value['orderTime']).toLocal(),
            cartItems: (value['cartItems'] as List<dynamic>).map((item) {
              return CartItemData(
                  item['id'], item['title'], item['quantity'], item['price']);
            }).toList()));
        return acc;
      }).reversed.toList();
      _orders.addAll(list);
      notifyListeners();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }
}
