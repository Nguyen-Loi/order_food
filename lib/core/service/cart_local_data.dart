import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/cart.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Class này sẽ chứa những dữ liệu local

class CartLocalData {
  Future<void> loadDataCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('cart') != null) {
      String strCart = pref.getString('cart')!;
      locator<DataApp>().listCart = Cart.decode(strCart);
    }
  }

  ///Thêm vào giỏ
  Future<void> addItemCart(String productID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isContainerID = false;
    for (int i = 0; i < locator<DataApp>().listCart.length; i++) {
      if (locator<DataApp>().listCart[i].refID == productID) {
        isContainerID = true;
        locator<DataApp>().listCart[i] = Cart(
            refID: locator<DataApp>().listCart[i].refID,
            quantity: locator<DataApp>().listCart[i].quantity + 1);
        locator<DataApp>().listCart[i] = locator<DataApp>().listCart[i];
      }
    }

    if (!isContainerID) {
      locator<DataApp>().listCart.add(Cart(refID: productID, quantity: 1));
    }

    try {
      String encodeJson = Cart.encode(locator<DataApp>().listCart);
      await prefs.setString('cart', encodeJson);
      await loadDataCart();
    } catch (e) {
      logError('Có lỗi xãy ra: $e');
    }
  }

  ///Xóa khỏi giỏ hàng
  Future<void> removeItemCard(String productID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < locator<DataApp>().listCart.length; i++) {
      if (locator<DataApp>().listCart[i].refID == productID) {
        Cart cart = locator<DataApp>().listCart[i];
        if (cart.quantity > 1) {
          locator<DataApp>().listCart[i] =
              Cart(refID: cart.refID, quantity: cart.quantity - 1);
          locator<DataApp>().listCart[i] = locator<DataApp>().listCart[i];
        } else {
          await locator<GetNavigation>().openDialog(
              typeDialog: TypeDialog.ask,
              onSubmit: () {
                locator<DataApp>().listCart.removeAt(i);
                locator<GetNavigation>().back();
                logError('Đã remove ');
              },
              content:
                  'Bạn có chắc muốn xóa món ăn này ra khỏi giỏ hàng không?');
        }
      }
    }

    String encodeJson = Cart.encode(locator<DataApp>().listCart);
    await prefs.setString('cart', encodeJson);
    await loadDataCart();
  }

  ///Xóa hết
  Future<void> clearAllDialog() async {
    if (locator<DataApp>().listCart.isEmpty) {
      locator<GetNavigation>().openDialog(
          typeDialog: TypeDialog.waring,
          content: 'Hiện bạn không có món ăn nào trong giỏ hàng');
    } else {
      await locator<GetNavigation>().openDialog(
          typeDialog: TypeDialog.ask,
          onSubmit: () async {
            clearAll();
            locator<GetNavigation>().back();
          },
          content:
              'Bạn có chắc muốn xóa tất cả món ăn ra khỏi giỏ hàng không?');
    }
  }

  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locator<DataApp>().listCart.clear();
    String encodeJson = Cart.encode(locator<DataApp>().listCart);
    await prefs.setString('cart', encodeJson);
    await loadDataCart();
  }
}
