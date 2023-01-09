import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';

class ACategoryViewController extends BaseController {
  List<Category> get listCategory => data.map((e) => Category(e)).toList();

 @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
     Api api = Api(BaseTable.category);

    return  api.streamDataCollection();
  }
}
