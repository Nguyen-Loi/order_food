import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/a_image.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/user/u_profile_view/controller/u_profile_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';
import 'package:project_order_food/ui/widget/form/a_button_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_text_form_field.dart';
import 'package:project_order_food/core/extension/validation.dart';

class UProfileView extends BaseView<UProfileViewController> {
  UProfileView({super.key}) : super(UProfileViewController());

  final GlobalKey<FormState> keyF = GlobalKey<FormState>();
  @override
  Widget getMainView(BuildContext context, UProfileViewController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          avatarDefault(),
          UIHelper.verticalSpaceSmall(),
          contentForm(),
        ],
      ),
    );
  }

  Widget contentForm() {
    UserApp user = controller.user;
    return Form(
      key: keyF,
      child: ColumnWithSpacing(
        spacing: 16,
        children: [
          AText.body('Email: ${user.email}'),
          ATextFormField(
            label: 'Username',
            initValue: user.userName,
            hintText: 'Nguyễn Nam',
            onSaved: (v) => controller.userName=v,
          ),
          ATextFormField(
              label: 'PhoneNumber',
              hintText: '12345678',
              initValue: user.phoneNumber,
              keyboardType: TextInputType.phone,
               onSaved: (v) => controller.phoneNumber=v,
              validator: (v) => v!.isEmpty || !v.isValidPhone
                  ? 'Số điện thoại không hợp lệ'
                  : null),
        ],
      ),
    );
  }

  @override
  Widget? bottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: AButtonFormField(
        keyF,
        onValidateSuccess: () {
          controller.updateProfile();
        },
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Thông tin cá nhân');
  }

  Widget avatarDefault() {
    return CircleAvatar(
      radius: 40,
      child: Image.asset(AImage.user),
    );
  }
}
