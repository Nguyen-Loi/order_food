import 'dart:io';

import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/extension/extension.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';

class AAddProductViewController extends BaseController {
  String? _title;
  File? _file;
  String? _description;
  String? _price;
  String? _discountPrice;
  String? _refID;

  List<Category> get listCategory => locator<DataApp>().listCategoy;

  set title(String? value) {
    _title = value;
  }

  set file(File? value) {
    _file = value;
  }

  set description(String? value) {
    _description = value;
  }

  set price(String? value) {
    _price = value;
  }

  set discountPrice(String? value) {
    _discountPrice = value;
  }

  set refID(String? value) {
    _refID = value;
  }

  void addProduct() async {
    Api api = Api(BaseTable.product);
    await api.addDocument({
      FieldName.title: _title,
      FieldName.description: _description,
      FieldName.price: int.parse(_price ?? '1'),
      FieldName.discountPrice: int.parse(_discountPrice ?? '1'),
      FieldName.refID: _refID,
    }, file: _file).then((value) {
      value.backOrNotification();
    });
  }
}
