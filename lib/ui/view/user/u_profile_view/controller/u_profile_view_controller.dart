import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/field_name.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/core/service/api.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:project_order_food/ui/base_app/base_table.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class UProfileViewController extends BaseController {
  String? _userName;
  String? _phoneNumber;

  UserApp get user => locator<DataApp>().user;

  set userName(String? value) {
    _userName = value;
  }

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  void updateProfile() async {
    Api api = Api(BaseTable.user);
    Map<String, dynamic> newData = {
      FieldName.userName: _userName,
      FieldName.phoneNumber: _phoneNumber,
    };

    logSuccess(newData.toString());

    await api.updateDocument(newData, user.id).then((value) {
      if (value != null) {
        locator<GetNavigation>().openDialog(content: value);
      } else {
        locator<GetNavigation>()
            .openDialog(
                content: 'Thay đổi thông tin thành công',
                typeDialog: TypeDialog.sucesss)
            .whenComplete(() {
          locator<DataApp>().reloadUserData();
        });
      }
    });
  }
}
