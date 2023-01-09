import 'package:flutter/cupertino.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/service/authenication_service.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class LoginController {
  String? _email;
  String? _password;

  set userName(String? value) {
    _email = value;
  }

  set password(String? value) {
    _password = value;
  }

  void signIn(BuildContext context) async {
    if (_email == 'admin@gmail.com' && _password == 'admin') {
      locator<GetNavigation>().replaceTo(RoutePaths.loadingView);
      logSuccess('Đăng nhập với tư cách admin');
    } else {
      final AuthenticationService auth = AuthenticationService();
      await auth.signIn(_email ?? '', _password ?? '').then((value) {
        if (value == null) {
          locator<GetNavigation>().replaceTo(RoutePaths.loadingView);
          logSuccess('Đăng nhập với tư cách người dùng');
        } else {
          ADialog.show(context, content: value);
        }
      });
    }
  }
}
