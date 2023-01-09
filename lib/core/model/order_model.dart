import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/extension/methods.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/model.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/model/status_order.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';

class OrderModel extends Model {
  OrderModel(super.data);

  String get totalPrice => Methods.getPriceVND(data, FieldName.totalPrice);
  String get userID => Methods.getString(data, FieldName.userID);

  Product get product => Methods.getMap(data, FieldName.product);

  StatusOrder get status {
    List<StatusOrder> list = locator<DataApp>().listStatusOdrer;
    for (var e in list) {
      if (e.id == refID) {
        return e;
      }
    }
    logError('Trạng thái status không chính xác z $refID');
    return list.first;
  }

  @override
  String get createDate =>
      Methods.convertTime(Methods.getDateTime(data, FieldName.createDate),
          defaultFormat: 'dd/MM/yyyy - HH:mm');
}
