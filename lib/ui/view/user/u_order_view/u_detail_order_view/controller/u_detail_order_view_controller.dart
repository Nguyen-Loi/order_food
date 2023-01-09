import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/order_detail_model.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';

class UDetailOrderViewController extends BaseController {
  UDetailOrderViewController({required this.orderID});
  final String orderID;

  List<OrderDetailModel> get listOrderDetail =>
      data.map((e) => OrderDetailModel(e)).toList();

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    return FirebaseFirestore.instance
        .collection(BaseTable.orderDetail)
        .where(FieldName.refID, isEqualTo: orderID)
        .get();
  }
}
