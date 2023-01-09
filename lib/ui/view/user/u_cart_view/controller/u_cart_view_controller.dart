import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_order_food/core/extension/enum.dart';
import 'package:project_order_food/core/model/cart.dart';
import 'package:project_order_food/core/model/cart_product.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/cart_local_data.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class UCartViewController extends BaseController {
  final CartLocalData _localCart = CartLocalData();

  List<Cart> get _listCart => locator<DataApp>().listCart;
  List<Product> get _listProduct => locator<DataApp>().listProduct;

  List<CartProduct> get listCartProduct {
    List<CartProduct> listCartProduct = [];
    for (final ePro in _listProduct) {
      for (final eCart in _listCart) {
        if (ePro.id == eCart.refID) {
          listCartProduct.add(CartProduct({
            FieldName.product: ePro,
            FieldName.cart: eCart,
          }));
        }
      }
    }
    return listCartProduct;
  }

  int get tongGia {
    int value = 0;
    for (var e in listCartProduct) {
      value += e.cart.quantity * e.product.price;
    }

    return value;
  }

  void checkout() async {
    Map<String, Object> dataOrder = {
      FieldName.totalPrice: tongGia,
      FieldName.userID: locator<DataApp>().user.id,
      FieldName.createDate: DateTime.now(),
      FieldName.refID: EStatusOrder.choXacNhan.getInfo.id,
    };
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection(BaseTable.order)
        .add(dataOrder);

    Api apiOrderDetail = Api(BaseTable.orderDetail);
    for (var e in _listCart) {
      await apiOrderDetail.addDocument({
        FieldName.refID: docRef.id,
        FieldName.quantity: e.quantity,
        FieldName.productID: e.refID
      });
    }

    await _localCart.clearAll().whenComplete(() {
      locator<GetNavigation>().openDialog(
          content: 'Thanh toán thành công',
          typeDialog: TypeDialog.sucesss,
          onClose: () {
            locator<GetNavigation>().to(RoutePaths.uHomeView);
          });
    });
  }

  void clearAll() {
    _localCart.clearAllDialog().whenComplete(() {
      notifyListeners();
    });
  }

  void addItem(String productID) {
    _localCart.addItemCart(productID).whenComplete(() {
      notifyListeners();
    });
  }

  void removeItem(String productID) {
    _localCart.removeItemCard(productID).whenComplete(() {
      notifyListeners();
    });
  }
}
