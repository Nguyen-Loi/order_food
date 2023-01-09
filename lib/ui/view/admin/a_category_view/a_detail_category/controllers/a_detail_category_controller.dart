import 'dart:io';

import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';

class ADetailCategoryController extends BaseController {
  ADetailCategoryController(this.category);
  final Category category;

  final Api _api = Api(BaseTable.category);

  String? _title;
  File? _file;

  set title(String? value) {
    _title = value;
  }

  set file(File? file) {
    _file = file;
  }

  void updateFile() async {
    Map<String, dynamic> value = category.data;
    value.addAll({
      FieldName.title: _title ?? category.title,
    });
    await _api.updateDocument(value, category.id, file: _file).then((value) {
      if (value == null) {
          locator<DataApp>().reloadCategory();
        locator<GetNavigation>().back();
      
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

  void deleteCategory() async {
    await _api.removeDocument(category.id).then((value) {
      if (value == null) {
          locator<DataApp>().reloadCategory();
        locator<GetNavigation>().back();
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }
}
