import 'package:deliver_it/data/repository/cart_repo.dart';
import 'package:deliver_it/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _cartItems = {};
  Map<int, CartModel> get cartItems => _cartItems;

  void addToCart(ProductModel product, int quantity) {
    int totalQuantity = 0;
    if (_cartItems.containsKey(product.id!)) {
      _cartItems.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isAdded: true,
          createdAt: DateTime.now().toString(),
        );
      }
      );
      if (totalQuantity <= 0) {
        _cartItems.remove(product.id!);
      }
    }
    else {
      if (quantity > 0) {
        _cartItems.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isAdded: true,
            createdAt: DateTime.now().toString(),
          );
        });
      }
      else {
        Get.snackbar(
          "Error",
          "You must add at least 1 item to cart!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  bool existsInCart(ProductModel product) {
    if (_cartItems.containsKey(product.id!)) {
      return true;
    }
    else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    if (_cartItems.containsKey(product.id!)) {
      return _cartItems[product.id!]!.quantity!;
    }
    else {
      return 0;
    }
  }

  int get totalItems {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity!;
    });
    return total;
  }

  List<CartModel> get cartList {
    List<CartModel> list = [];
    _cartItems.forEach((key, value) {
      list.add(value);
    });
    return list;
  }
}