import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/a_image.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';

class ADetailUserView extends StatelessWidget {
  final UserApp user;

  const ADetailUserView({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppbar(title: 'Thông tin chi tiết'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child:Image.asset(AImage.userDefault)),
          UIHelper.verticalSpaceSmall(),
          content()
        ],
      ),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ColumnWithSpacing(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Email
          if (user.email.isNotEmpty)
            itemContent(label: 'Email: ', content: user.email),
          //UserName
          if (user.userName.isNotEmpty)
            itemContent(label: 'UserName: ', content: user.userName),
          //CraeteDate
          if (user.createDate.isNotEmpty)
            itemContent(label: 'Ngày tạo: ', content: user.createDate),
          //Phone
          if (user.phoneNumber.isNotEmpty)
            itemContent(label: 'Số điện thoại: ', content: user.phoneNumber),
        ],
      ),
    );
  }

  Widget itemContent({required String label, required String content}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: label, style: ATextStyle.caption()),
          TextSpan(text: content, style: ATextStyle.body(color: AColor.black)),
        ],
      ),
    );
  }
}
