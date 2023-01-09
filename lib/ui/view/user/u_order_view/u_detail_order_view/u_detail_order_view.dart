import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/order_detail_model.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/user/u_order_view/u_detail_order_view/controller/u_detail_order_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';

class UDetailOrderView extends BaseView<UDetailOrderViewController> {
  UDetailOrderView({
    required String orderID,
    super.key,
  }) : super(
          UDetailOrderViewController(orderID: orderID),
        );

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Chi tiết đơn hàng');
  }

  @override
  Widget getMainView(
      BuildContext context, UDetailOrderViewController controller) {
    List<OrderDetailModel> list = controller.listOrderDetail;
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 3 / 4),
      itemBuilder: (_, index) => card(list[index]),
    );
  }

  Widget card(OrderDetailModel model) {
    Product product = model.product;
    return GestureDetector(
      onTap: () {
        locator<GetNavigation>()
            .to(RoutePaths.uDetailProductView, arguments: product);
      },
      child: Container(
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
                tag: product.id,
                child: Container(
                  color: Colors.red,
                  child: Image.network(
                    product.img,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ColumnWithSpacing(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AText.listItem(product.title),
                  AText.body(
                    'Giá: ${product.discountPrice}',
                    color: AColor.red,
                  ),
                  AText.body(
                    'Số lượng đã mua: ${model.quantity}',
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
