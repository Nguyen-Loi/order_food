import 'package:flutter/material.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/a_image.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/admin/a_home_view/components/item_category.dart';
import 'package:project_order_food/ui/widget/a_button.dart';

class AHomeView extends StatelessWidget {
  const AHomeView({super.key});

  List<ItemCategoryModel> list(BuildContext context) {
    return [
      ItemCategoryModel(
          title: 'Món ăn',
          strAsset: AImage.food,
          onTap: () {
            locator<GetNavigation>().to(RoutePaths.aProductView);
          }),
      ItemCategoryModel(
          title: 'Danh mục',
          strAsset: AImage.category,
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.aCategorView);
          }),
      ItemCategoryModel(
          title: 'Đơn đặt hàng',
          strAsset: AImage.order,
          onTap: () {
            locator<GetNavigation>().to(RoutePaths.aOrderView);
          }),
      ItemCategoryModel(
          title: 'Người dùng',
          strAsset: AImage.user,
          onTap: () {
            locator<GetNavigation>().to(RoutePaths.aUserView);
          })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 16),
        child: Column(
          children: [
            AText.title('Quản lý'),
            Expanded(
              child: GridView.builder(
                  itemCount: list(context).length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 4.0),
                  itemBuilder: (_, index) =>
                      ItemCategory(list(context)[index])),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
        child: AButton.text(
          'Đăng xuất',
          isExpanded: true,
          onPressed: () {
            locator<GetNavigation>().toLogout();
          },
          color: AColor.red,
        ),
      ),
    );
  }
}
