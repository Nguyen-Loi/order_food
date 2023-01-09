import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/a_image.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/user/u_home_view/controllers/u_home_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';

class UHomeView extends BaseView<UHomeViewController> {
  UHomeView({super.key}) : super(UHomeViewController());

  @override
  Widget getMainView(BuildContext context, UHomeViewController controller) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: min(18, controller.listFood.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 4.0),
      itemBuilder: (_, index) => cardFood(
        controller.listFood[index],
      ),
    );
  }

  @override
  Widget? get drawer => Drawer(child: drawerItems);

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(
      title: 'Trang chủ',
      suffix: IconButton(
          onPressed: () {
            locator<GetNavigation>().to(RoutePaths.uCartView);
          },
          icon: const Icon(Icons.shopping_basket)),
    );
  }

  Widget get drawerItems => ListView(children: [
        drawerHeader,
        ListTile(
          title: AText.body(
            'Danh mục',
          ),
          leading: const Icon(Icons.category),
          onTap: () {
            locator<GetNavigation>().back().whenComplete(() {
              locator<GetNavigation>().to(RoutePaths.uCategoryView);
            });
          },
        ),
        ListTile(
          title: AText.body(
            'Đơn hàng',
          ),
          leading: const Icon(Icons.history),
          onTap: () {
            locator<GetNavigation>().back().whenComplete(() {
              locator<GetNavigation>().to(RoutePaths.uOrderView);
            });
          },
        ),
        ListTile(
          title: AText.body('Đăng xuất', color: AColor.red),
          leading: const Icon(Icons.logout),
          onTap: () {
            locator<GetNavigation>().toLogout();
          },
        )
      ]);

  UserAccountsDrawerHeader get drawerHeader => UserAccountsDrawerHeader(
        accountName: AText.body('Chào mừng'),
        accountEmail: AText.body(
          controller.user.email,
        ),
        currentAccountPicture: GestureDetector(
          onTap: () {
            locator<GetNavigation>().to(RoutePaths.uProfileView);
          },
          child: CircleAvatar(
            child: Image.asset(AImage.userDefault),
          ),
        ),
      );

  Widget cardFood(Product model) {
    return GestureDetector(
      onTap: () {
        locator<GetNavigation>()
            .to(RoutePaths.uDetailProductView, arguments: model);
      },
      child: Container(
        height: 80,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AColor.greenBold, width: 0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: model.id,
                child: Container(
                  color: Colors.red,
                  child: Image.network(
                    model.img,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ColumnWithSpacing(
                children: [
                  AText.listItem(model.title),
                  Row(
                    children: [
                      Expanded(
                        child: AText.caption(
                          model.strPrice,
                          color: AColor.red,
                          textDecoration: TextDecoration.lineThrough,
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      AText.body(model.discountPrice, color: AColor.red),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
