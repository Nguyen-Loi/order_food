import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/authenication_service.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/router.dart';

class RegisterController {
  String? _email;
  String? _password;

  set email(String? value) => _email = value;

  set password(String? value) => _password = value;

  String get password => _password ?? '';

  void signUp() async {
    final AuthenticationService auth = AuthenticationService();
    await auth.signUp(_email ?? '', _password ?? '').then((value) {
      if (value != null) {
        Api api = Api(BaseTable.user);
        User? currentUser = value.user;
        if (currentUser != null) {
          api.addDocument({
            FieldName.email: currentUser.email,
          }, customID: currentUser.uid).then((value) {
            if (value == null) {
              locator<GetNavigation>().replaceTo(RoutePaths.loadingView);
            } else {
              locator<GetNavigation>().openDialog(content: value);
            }
          });
        } else {
          logError('Không lấy được thông tin người dùng đăng ký');
        }
      }
    });
  }
}
