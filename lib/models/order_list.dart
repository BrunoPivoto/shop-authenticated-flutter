// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

import '../utils/constants.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  String _token;
  String _userId;
  List<Order> _items = [];

  OrderList([this._token = '', this._userId = '', this._items = const []]);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];
    final response = await http.get(Uri.parse('${Constants.ordersBaseUrl}/$_userId.json?auth=$_token'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(Order(
        id: orderId,
        date: DateTime.parse(orderData['date']),
        total: orderData['total'],
        products: (orderData['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            productId: item['productId'],
            name: item['name'],
            qnt: item['qnt'],
            price: item['price'],
          );
        }).toList(),
      ));
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ordersBaseUrl}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map(
                (cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'qnt': cartItem.qnt + 1,
                  'price': cartItem.price,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
