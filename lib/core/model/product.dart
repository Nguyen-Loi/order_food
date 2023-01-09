import 'package:project_order_food/core/extension/methods.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/model.dart';

class Product extends Model {
  Product(super.data);
  String get title => Methods.getString(data, FieldName.title);
  String get description => Methods.getString(data, FieldName.description);
  String get strPrice => Methods.getPriceVND(data, FieldName.price);
  int get price => Methods.getInt(data, FieldName.price);
  String get discountPrice =>
      Methods.getPriceVND(data, FieldName.discountPrice);
}
