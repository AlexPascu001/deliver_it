import 'package:deliver_it/controllers/cart_controller.dart';
import 'package:deliver_it/data/repository/popular_product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/products_model.dart';
class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    // print("Getting popular product list");
    Response response = await popularProductRepo.getPopularProductList();
    //print("Response: ${response.statusCode}");
    if (response.statusCode == 200) {

      //print("Success! got popular product list");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    }
    else {
      // print("Error: ${response.statusText}");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      update();
    }
    else {
      _quantity = checkQuantity(_quantity - 1);
      update();
    }
  }

  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar(
          "Error",
          "You can't add less than 0 items to cart!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }
    else {
      if (_inCartItems + quantity > 20) {
        Get.snackbar(
            "Error",
            "You can only add 20 products of the same type to cart!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
        );
        return 20;
      }
      else {
        return quantity;
      }
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exists = _cart.existsInCart(product);
    // get from storage _inCartItems
    if (exists) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("exists: $exists");
    print("inCartItems: $_inCartItems");
  }

  void addToCart(ProductModel product) {
    _cart.addToCart(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.cartItems.forEach((key, value) {
      print("Key: ${value.id.toString()}, Value: ${value.quantity}");
    });
    update();
  }

  int get totalItems => _cart.totalItems;

  List<CartModel> get cartItems => _cart.cartList;

}