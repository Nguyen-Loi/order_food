import 'package:collection/collection.dart';

import 'package:project_order_food/core/extension/methods.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/model.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';

class OrderDetailModel extends Model {
  OrderDetailModel(super.data);

  int get quantity => Methods.getInt(data, FieldName.quantity);

  String get productID => Methods.getString(data, FieldName.productID);

  Product get product =>
      locator<DataApp>()
          .listProduct
          .firstWhereOrNull((e) => e.id == productID) ??
      locator<DataApp>().listProduct.first;
}
