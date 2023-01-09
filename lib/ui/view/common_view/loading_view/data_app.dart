import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_order_food/core/extension/extension.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/cart.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/model/status_order.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/authenication_service.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/core/service/cart_local_data.dart';
import 'package:project_order_food/locator.dart';

import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/router.dart';

class DataApp {
  List<Category> _listCategoy = [];
  List<Category> get listCategoy => _listCategoy;

  List<StatusOrder> _listStatusOrder = [];
  List<StatusOrder> get listStatusOdrer => _listStatusOrder;

  List<Product> _listProduct = [];
  List<Product> get listProduct => _listProduct;

  UserApp _user = UserApp({});
  UserApp get user => _user;

  List<Cart> listCart = [];

  ///Cập nhất thông tin thì sẽ reload lại
  void reloadUserData() async {
    if (loadDataUser() == null) {
      logSuccess('Tải dữ liệu người admin');
      _user = userDefault;
    } else {
      await loadDataUser()!.then((value) {
        _user = UserApp(
            {...value.data() as Map<String, dynamic>, FieldName.id: value.id});
        logSuccess('Tải dữ liệu người dùng: ${_user.toString()}');
      });
    }
  }

  Future<void> reloadSanPham() async {
    await loadDataProduct().then((value) {
      _listProduct = value.toListMap().map((e) => Product(e)).toList();
      logSuccess('Tải thông tin sản phẩm: ${_listProduct.length}');
    });
  }
 
  Future<void> reloadCategory() async {
    await loadDataCategory().then((value) {
      _listCategoy = value.toListMap().map((e) => Category(e)).toList();
      logSuccess('Tải danh sách danh mục: ${_listCategoy.length}');
    });
  }

  Future<DocumentSnapshot>? loadDataUser() {
    AuthenticationService service = AuthenticationService();
    if (service.getCurrentUser() != null) {
      String uid = service.getCurrentUser()!.uid;
      Api api = Api(BaseTable.user);
      return api.getDocumentById(uid);
    }
    return null;
  }

  Future<QuerySnapshot<Object?>> loadDataCategory() {
    _listCategoy.clear();
    logInfo('Tải danh sách danh mục ...${_listCategoy.length}');
    Api api = Api(BaseTable.category);
    return api.getDataCollection();
  }

  Future<QuerySnapshot<Object?>> loadDataStatusOrder() {
    _listStatusOrder.clear();
    logInfo('Tải trạng thái đặt hàng ...${_listStatusOrder.length}');
    Api api = Api(BaseTable.statusOrder);
    return api.getDataCollection();
  }

  Future<QuerySnapshot<Object?>> loadDataProduct() {
    _listProduct.clear();
    logInfo('Tải danh sách sản phẩm ...${_listProduct.length}');
    Api api = Api(BaseTable.product);
    return api.getDataCollection();
  }

  UserApp get userDefault {
    return UserApp({'email': 'admin@gmail.com', 'password': 'admin'});
  }

  void initData() async {
    reloadUserData();

    await Future.delayed(const Duration(seconds: 1));
    CartLocalData loadCart = CartLocalData();
    await loadCart.loadDataCart().then((_) {
      logSuccess('Tải thông tin giỏ hàng');
    });

    await Future.delayed(const Duration(seconds: 1));
   await reloadCategory();

    await Future.delayed(const Duration(seconds: 1));
    await loadDataStatusOrder().then((value) {
      _listStatusOrder = value.toListMap().map((e) => StatusOrder(e)).toList();
      logSuccess('Tải trạng thái đặt hàng: ${_listStatusOrder.length}');
    });

    await Future.delayed(const Duration(seconds: 1));

    await reloadSanPham();
    completeLoad();
  }

  void completeLoad() {
    String routerPath = user.email == userDefault.email
        ? RoutePaths.aHomeView
        : RoutePaths.uHomeView;
    try {
      locator<GetNavigation>().replaceTo(routerPath);
      logSuccess('Tải hoàn tất');
    } catch (e) {
      logError('Router path không hợp lệ');
    }
  }
}
