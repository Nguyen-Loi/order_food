import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_order_food/core/model/order_model.dart';
import 'package:project_order_food/core/model/status_order.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';

class AOrderViewController extends BaseController {
  final Api _api = Api(BaseTable.order);

  String? statusID;

  final List<OrderModel> _listOrder = [];

  List<OrderModel> get listOrder => _listOrder;

  @override
  void setData(QuerySnapshot<Object?>? value) {
    super.setData(value);
    _listOrder.clear();
    _listOrder.addAll(allListOrder);
    log('rebuild new data: ${_listOrder.first.refID}');
  }

  @override
  void reload() {
    statusID = null;
    super.reload();
  }

  void updateStatus(String newID) {
    _listOrder.clear();
    _listOrder.addAll(allListOrder);
    
    if (statusID == newID) {
      statusID = null;
    } else {
      statusID = newID;
      _listOrder.removeWhere((element) => element.refID != statusID);
    }
    notifyListeners();
  }

  List<StatusOrder> get listStatus => locator<DataApp>().listStatusOdrer;

  List<OrderModel> get allListOrder => data.map((e) => OrderModel(e)).toList()
    ..sort((a, b) => b.createDate.compareTo(a.createDate));

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    return _api.getDataCollection();
  }
}
