import 'package:flutter/foundation.dart';
import 'package:shopp/providers/product.provider.dart';

class CartItemData {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemData(this.id, this.title, this.quantity, this.price);
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItemData> _items = {};

  Map<String, CartItemData> get items {
    return _items;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    return _items.entries.fold(
        0, (price, item) => price + item.value.price * item.value.quantity);
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (val) =>
              CartItemData(val.id, val.title, val.quantity + 1, val.price));
      return;
    }
    _items.putIfAbsent(product.id,
        () => CartItemData(product.id, product.title, 1, product.price));

    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItemFromCart(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if ((_items[productId] as CartItemData).quantity > 1) {
      _items.update(
          productId,
          (currentData) => CartItemData(currentData.id, currentData.title,
              currentData.quantity - 1, currentData.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
