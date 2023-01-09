import 'package:project_order_food/core/extension/methods.dart';
import 'package:project_order_food/core/model/cart.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/model.dart';
import 'package:project_order_food/core/model/product.dart';

class CartProduct extends Model {
  CartProduct(super.data);

  Product get product => Methods.getMap(data, FieldName.product);
  Cart get cart => Methods.getMap(data, FieldName.cart);

  @override
  String toString() {
    return 'Product: {id: ${product.id}, title: ${product.title}} - Cart: {quantity: ${cart.quantity}}';
  }
}
