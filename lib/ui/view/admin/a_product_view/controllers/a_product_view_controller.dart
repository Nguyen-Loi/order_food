import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';

class AProductViewController extends BaseController {
  List<Product> get listProduct => data.map((e) => Product(e)).toList();

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    Api api = Api(BaseTable.product);
    return api.streamDataCollection();
  }
}
