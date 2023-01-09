import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/admin/a_product_view/controllers/a_product_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';

class AProductView extends BaseView<AProductViewController> {
  AProductView({super.key}) : super(AProductViewController());

  @override
  Widget getMainView(BuildContext context, AProductViewController controller) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.listProduct.length,
      separatorBuilder: (_, __) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (_, int index) {
        return productCard(controller.listProduct[index]);
      },
    );
  }

  Widget productCard(Product product) {
    return GestureDetector(
      onTap: () {
        locator<GetNavigation>()
            .to(RoutePaths.aADetailProductView, arguments: product);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 120,
        decoration: BoxDecoration(
            color: AColor.primary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AColor.grey)),
        child: Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Image.network(
                  product.img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AText.listItem(product.title),
                    AText.body('Ngày tạo: ${product.createDate}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AText.caption(product.strPrice,
                            color: AColor.red,
                            textDecoration: TextDecoration.lineThrough),
                        AText.body(
                          'Giá: ${product.discountPrice}',
                          color: AColor.red,
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Danh sách');
  }

  @override
  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        locator<GetNavigation>().to(RoutePaths.aAddProductView);
      },
      child: const Icon(Icons.add),
    );
  }
}
