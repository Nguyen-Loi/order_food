import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/order_model.dart';
import 'package:project_order_food/core/model/status_order.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/admin/a_order_view/controllers/a_order_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';

class AOrderView extends BaseView<AOrderViewController> {
  AOrderView({super.key}) : super(AOrderViewController());

  @override
  Widget getMainView(BuildContext context, AOrderViewController controller) {
    return Column(
      children: [
        UIHelper.verticalSpaceSmall(),
        listCategory(),
        UIHelper.verticalSpaceSmall(),
        Expanded(
          child: controller.listOrder.isEmpty
              ? Center(
                  child: AText.listItem('Không có hóa đơn nào'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.listOrder.length,
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemBuilder: (_, int index) {
                    return orderCard(controller.listOrder[index]);
                  },
                ),
        )
      ],
    );
  }

  Widget listCategory() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: controller.listStatus.map((e) => itemStatus(e)).toList(),
    );
  }

  Widget itemStatus(StatusOrder status) {
    bool isSelected = status.id == controller.statusID;
    return GestureDetector(
      onTap: () {
        controller.updateStatus(status.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AColor.yellow : AColor.white,
          border: Border.all(color: AColor.grey, width: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: isSelected
            ? AText.listItem(status.title)
            : AText.body(status.title),
      ),
    );
  }

  Widget orderCard(OrderModel model) {
    return GestureDetector(
      onTap: () async {
        await locator<GetNavigation>()
            .to(RoutePaths.aOrderDetailView, arguments: model)
            .whenComplete(() => controller.reload());
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: AColor.grey, width: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(
              'https://banner2.cleanpng.com/20180315/ciw/kisspng-bill-download-royalty-free-clip-art-legal-studies-cliparts-5aab2d905c6264.7535060015211677603784.jpg',
              height: 90,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AText.listItem('Trạng thái: ${model.status.title}'),
                AText.body('Thời gian đặt: ${model.createDate}'),
                AText.body('Tổng: ${model.totalPrice}', color: AColor.red),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Danh sách hóa đơn');
  }
}
