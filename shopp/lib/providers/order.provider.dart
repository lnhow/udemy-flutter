import 'package:flutter/foundation.dart';
import 'package:shopp/providers/cart.provider.dart';

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

  void placeOrder(List<CartItemData> cartItems, double total) {
    final now = DateTime.now();
    _orders.add(OrderData(
        id: now.toString(),
        total: total,
        cartItems: cartItems,
        orderTime: now));
    notifyListeners();
  }
}
