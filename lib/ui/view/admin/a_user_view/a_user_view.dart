import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/a_image.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/admin/a_user_view/controllers/a_user_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';

class AUserView extends BaseView<AUserViewController> {
  AUserView({super.key}) : super(AUserViewController());

  @override
  Widget getMainView(BuildContext context, AUserViewController controller) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.listUser.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, int index) {
        return userCard(controller.listUser[index]);
      },
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Danh sách người dùng');
  }

  Widget userCard(UserApp model) {
    return GestureDetector(
      onTap: () {
        locator<GetNavigation>().to(RoutePaths.aDetailUserView, arguments: model);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AColor.grey, width: 0.2),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: Image.asset(AImage.userDefault)),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AText.listItem(model.email),
                  AText.body('Ngày tạo: ${model.createDate}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
