import 'package:project_order_food/core/model/status_order.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';

enum EStatusOrder {
  choXacNhan,
  daXacNhan,
  daHoanThanh;
}

extension StatusOrderExtension on EStatusOrder {
  StatusOrder get getInfo {
    List<StatusOrder> list = locator<DataApp>().listStatusOdrer;
    switch (this) {
      case EStatusOrder.choXacNhan:
        return list[0];
      case EStatusOrder.daXacNhan:
        return list[1];
      case EStatusOrder.daHoanThanh:
        return list[2];
    }
  }
}
