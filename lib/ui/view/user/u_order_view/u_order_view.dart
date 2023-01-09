import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/order_model.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/a_image.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/user/u_order_view/controller/u_order_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';

class UOrderView extends BaseView<UOderViewController> {
  UOrderView({super.key}) : super(UOderViewController());

  @override
  Widget getMainView(BuildContext context, UOderViewController controller) {
    List<OrderModel> list = controller.listOrder;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        return cardOrder(list[index]);
      },
    );
  }

  Widget cardOrder(OrderModel order) {
    return GestureDetector(
      onTap: () {
        locator<GetNavigation>()
            .to(RoutePaths.uDetailOrderView, arguments: order.id);
      },
      child: SizedBox(
        height: 80,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AColor.grey)),
          child: Row(
            children: [
              Image.asset(
                AImage.orderList,
                height: 80,
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AText.listItem(order.createDate),
                    AText.body('Trạng thái: ${order.status.title}'),
                    AText.body('Tổng: ${order.totalPrice}', color: AColor.red),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Danh sách đơn đặt');
  }
}
