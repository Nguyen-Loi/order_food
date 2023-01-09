import 'package:project_order_food/core/extension/methods.dart';
import 'package:project_order_food/core/model/field_name.dart';

class Model {
  Model(this.data);
  final Map<String, dynamic> data;
  String get id => Methods.getString(data, 'id');
  String get createDate =>
      Methods.convertTime(Methods.getDateTime(data, FieldName.createDate),
          defaultFormat: 'dd/MM/yyyy');
  ///Id danh mục
  String get refID => Methods.getString(data, FieldName.refID);
  String get img => Methods.getString(data, FieldName.img);
}
