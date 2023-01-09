import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';

class UHomeViewController extends BaseController {
  Api api = Api(BaseTable.product);

  List<Product> get listFood => locator<DataApp>().listProduct;

  UserApp get user => locator<DataApp>().user;
}
