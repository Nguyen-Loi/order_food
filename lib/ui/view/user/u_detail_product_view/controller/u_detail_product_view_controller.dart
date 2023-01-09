import 'package:project_order_food/core/service/cart_local_data.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class UDetailViewController extends BaseController {
  final CartLocalData _cartData = CartLocalData();


  void addCard(String productID) async {
    _cartData.addItemCart(productID).whenComplete(() {
      locator<GetNavigation>().openDialog(
          typeDialog: TypeDialog.sucesss,
          content: 'Thêm vào giỏ hàng thành công');
    });
  }
}
