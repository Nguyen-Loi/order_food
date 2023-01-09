import 'package:flutter/material.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/common_view/register/controllers/register_controller.dart';
import 'package:project_order_food/ui/widget/a_button.dart';
import 'package:project_order_food/ui/widget/form/a_text_form_field.dart';
import 'package:project_order_food/core/extension/validation.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final RegisterController controller = RegisterController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  AText.body('TOMOTOZ'),
                  UIHelper.verticalSpaceLarge(),
                  ATextFormField(
                    label: 'Email',
                    onSaved: (v) => controller.email = v,
                    validator: (v) => v!.isEmpty || !v.isValidEmail
                        ? 'Email không hợp lệ'
                        : null,
                  ),
                  UIHelper.verticalSpaceMedium(),
                  ATextFormField(
                    label: 'Mât khẩu',
                    obscureText: true,
                    onChanged: (v) => controller.password = v,
                    onSaved: (v) => controller.password = v,
                  ),
                  UIHelper.verticalSpaceMedium(),
                  ATextFormField(
                    label: 'Xác nhận mật khẩu',
                    obscureText: true,
                    validator: (v) =>
                        v!.isEmpty || v!=controller.password
                            ? 'Mật khẩu không trùng nhau'
                            : null,
  
                  ),
                  UIHelper.verticalSpaceMedium(),
                  AButton.text(
                    'Đăng ký',
                    isExpanded: true,
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        controller.signUp();
                      }
                    },
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: AButton.text(
            'Quay lại',
            isExpanded: true,
            color: AColor.red,
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutePaths.loginView);
            },
          )),
    );
  }
}
