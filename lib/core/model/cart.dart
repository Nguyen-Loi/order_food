import 'dart:convert';

import 'package:project_order_food/core/extension/methods.dart';
import 'package:project_order_food/core/model/field_name.dart';

class Cart {
  ///ID sản phẩm (món ăn)
  final String refID;
  final int quantity;
  Cart({
    required this.refID,
    required this.quantity,
  });

  //convert your object to map with toMap() method
  static Map<String, dynamic> toMap(Cart cart) {
    return {FieldName.refID: cart.refID, FieldName.quantity: cart.quantity};
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        refID: Methods.getString(json, FieldName.refID),
        quantity: Methods.getInt(json, FieldName.quantity));
  }

  // encode your map to string with encode(...) method
  static String encode(List<Cart> lCart) => json.encode(
        lCart.map((e) => toMap(e)).toList(),
      );

  //decode shared preference string to a map with decode(...) method
  static List<Cart> decode(String carts) =>
      (json.decode(carts) as List<dynamic>)
          .map((item) => Cart.fromJson(item))
          .toList();

  @override
  String toString() {
    return 'refID: $refID - quantity: $quantity';
  }
}
