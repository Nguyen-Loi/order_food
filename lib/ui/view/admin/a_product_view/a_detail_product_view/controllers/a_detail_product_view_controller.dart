import 'dart:io';

import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:collection/collection.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';

class ADetailProductViewController extends BaseController {
  ADetailProductViewController(this.product);
  final Product product;
  String? _title;
  File? _file;
  String? _description;
  String? _price;
  String? _discountPrice;
  String? _refID;

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

  Api api = Api(BaseTable.product);

  List<Category> get listCategory => locator<DataApp>().listCategoy;

  ///Lấy thông tin danh mục hiện tại
  Category get initCategory {
    return listCategory
            .firstWhereOrNull((element) => element.id == product.refID) ??
        listCategory.first;
  }

  void updateProduct() async {
    Map<String, dynamic> newData = {
      FieldName.title: _title,
      FieldName.description: _description,
      FieldName.price: int.parse(_price ?? '1'),
      FieldName.discountPrice: int.parse(_discountPrice ?? '1'),
      FieldName.refID: _refID,
      FieldName.img: product.img
    };

    logSuccess('Upload- $newData');
    await api
        .updateDocument(
      newData,
      product.id,
      file: _file,
    )
        .then((value) {
      if (value == null) {
        locator<DataApp>().reloadSanPham();

        locator<GetNavigation>().back();
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

  void deleteProduct() async {
    await api.removeDocument(product.id).then((value) {
      if (value == null) {
        locator<DataApp>().reloadSanPham();

        locator<GetNavigation>().back();
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }
}
