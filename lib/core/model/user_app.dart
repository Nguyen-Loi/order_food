import 'package:project_order_food/core/extension/methods.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/model.dart';

class UserApp extends Model {
  UserApp(super.data);

  String get email => Methods.getString(data, FieldName.email);
  String get userName => Methods.getString(data, FieldName.userName);
  String get phoneNumber => Methods.getString(data, FieldName.phoneNumber);

  @override
  String toString() {
    return 'UID: $id - Email: $email';
  }
}
