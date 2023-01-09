import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class AAddCategoryViewController extends ChangeNotifier {
  File? _fileImg;
  String? _title;

  set fileImg(File? file) {
    _fileImg = file;
  }

  set title(String? title) {
    _title = title;
  }

  void upload(BuildContext context) {
    Api api = Api('Category');
    api.addDocument({FieldName.title: _title}, file: _fileImg).then((value) {
      if (value == null) {
        
          locator<DataApp>().reloadCategory();
        Navigator.pop(context);
      } else {
        ADialog.show(context, content: value);
      }
    });
  }
}
