import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/user/u_category_view/controller/u_category_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';

class UCategoryView extends BaseView<UCategoryViewController> {
  UCategoryView({super.key}) : super(UCategoryViewController());

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Danh mục');
  }

  Widget listCategory() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: controller.listCategory.map((e) => itemCategory(e)).toList(),
    );
  }

  Widget itemCategory(Category category) {
    bool isSelected = category.id == controller.categoryID;
    return GestureDetector(
      onTap: () {
        controller.updateByCategory(category.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AColor.yellow : AColor.white,
          border: Border.all(color: AColor.grey, width: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: isSelected
            ? AText.listItem(category.title)
            : AText.body(category.title),
      ),
    );
  }

  @override
  Widget getMainView(BuildContext context, UCategoryViewController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          listCategory(),
          UIHelper.verticalSpaceSmall(),
          Expanded(
            child: listProduct(),
          )
        ],
      ),
    );
  }

  Widget listProduct() {
    List<Product> listProduct = controller.listProduct;
    return listProduct.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              controller.reloadNewData();
            },
            child: ListView.separated(
              itemCount: listProduct.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                return cardProduct(listProduct[i]);
              },
            ),
          )
        : Center(
            child: AText.listItem('không có sản phẩm nào'),
          );
  }

  Widget cardProduct(Product model) {
    double height = 90;
    return GestureDetector(
      onTap: () {
        locator<GetNavigation>()
            .to(RoutePaths.uDetailProductView, arguments: model);
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: AColor.grey, width: 0.2),
          borderRadius: BorderRadius.circular(16),
          color: AColor.primary,
        ),
        child: Row(
          children: [
            Hero(
              tag: model.id,
              child: AspectRatio(
                  aspectRatio: 7 / 6,
                  child: Image.network(
                    model.img,
                    height: height,
                  )),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AText.listItem(model.title),
                  AText.body('Ngày tạo: ${model.createDate}'),
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
            ))
          ],
        ),
      ),
    );
  }
}
