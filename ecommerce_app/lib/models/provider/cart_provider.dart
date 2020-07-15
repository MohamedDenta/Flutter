import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<ItemModel> cart_products = [];

  getCart() {
    return cart_products;
  }

  addRemoveToCart(ItemModel item) {
    if (item != null) {
      var index = cart_products.indexOf(item);
      if (index == -1) {
        cart_products.add(item);
      } else {
        cart_products.removeAt(index);
      }
      notifyListeners();
    }
  }

  // removeFromCart(Single_cart_product item) {
  //   var b = cart_products.remove(item);
  //   b ? print('deleted .. ') : print('failed to delete');
  //   notifyListeners();
  // }
}
