import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/order_detail_model.dart';
import 'package:project_order_food/core/model/order_model.dart';
import 'package:project_order_food/core/model/status_order.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class AOrderDetailViewController extends BaseController {
  final OrderModel order;
  AOrderDetailViewController({required this.order}) {
    statusID = order.refID;
  }

  UserApp _infoUser = UserApp({});

  String? statusID;

  OrderModel get infoOrder => order;

  UserApp get infoUser => _infoUser;

  int get tongGia {
    int value = 0;
    for (var e in listOrderDetail) {
      value += e.quantity * e.product.price;
    }
    return value;
  }

  List<OrderDetailModel> get listOrderDetail =>
      data.map((e) => OrderDetailModel(e)).toList();

  List<StatusOrder> get listStatus => locator<DataApp>().listStatusOdrer;

  void updateStatus(String newID) async {
    Api api = Api(BaseTable.order);
    await api
        .updateDocument({FieldName.refID: newID}, order.id).then((value) {
      if (value == null) {
        locator<GetNavigation>().openDialog(
            content: 'Câp nhật thông tin thành công',
            typeDialog: TypeDialog.sucesss);
        statusID = newID;
        notifyListeners();
      } else {
        locator<GetNavigation>().openDialog();
      }
    });
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() async {
    Api apiUser = Api(BaseTable.user);
    await apiUser.getDocumentById(order.userID).then((value) {
      _infoUser = UserApp(
          {...value.data() as Map<String, dynamic>, FieldName.id: value.id});
    });

    return FirebaseFirestore.instance
        .collection(BaseTable.orderDetail)
        .where(FieldName.refID, isEqualTo: order.id)
        .get();
  }
}
