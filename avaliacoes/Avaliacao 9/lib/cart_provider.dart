import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;

  const Product({required this.id, required this.name, required this.price});
}

class CartProvider with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  double get totalPrice {
    return _items.fold(0.0, (total, current) => total + current.price);
  }

  void addToCart(Product product) {
    _items.add(product);
    notifyListeners(); 
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}