
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_order_food/core/extension/extension.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/admin_model.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/authenication_service.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class LoginController {
  String? _email;
  String? _password;
  bool loginWithAdmin = false;


  set userName(String? value) {
    _email = value;
  }

  set password(String? value) {
    _password = value;
  }

  void signIn(BuildContext context) async {
    if (loginWithAdmin) {
      Api apiUser = Api(BaseTable.admin);
      final data = await apiUser.getDataCollection();
      final List<AdminModel> users =
          data.toListMap().map((e) => AdminModel(e)).toList();

      AdminModel? adminLogin = users.firstWhereOrNull(
          (e) => e.email == _email && e.password == _password);
      if (adminLogin != null) {
        locator<GetNavigation>().replaceTo(RoutePaths.loadingView, arguments: true);
        logSuccess('Đăng nhập với tư cách admin');
        return;
      }
      ADialog.show(context, content: 'Tài khoản hoặc mật khẩu không chính xác');
    } else {
      final AuthenticationService auth = AuthenticationService();
      await auth.signIn(_email ?? '', _password ?? '').then((value) {
        if (value == null) {
          locator<GetNavigation>().replaceTo(RoutePaths.loadingView, arguments: false);
          logSuccess('Đăng nhập với tư cách người dùng');
        } else {
          ADialog.show(context, content: value);
        }
      });
    }
  }
}
