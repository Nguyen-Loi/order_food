import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/order_detail_model.dart';
import 'package:project_order_food/core/model/order_model.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/admin/a_order_view/a_order_detail_view/controllers/a_order_detail_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';
import 'package:project_order_food/core/extension/extension.dart';

class AOrderDetailView extends BaseView<AOrderDetailViewController> {
  AOrderDetailView({required OrderModel orderModel, super.key})
      : super(AOrderDetailViewController(order: orderModel));

  @override
  Widget getMainView(
      BuildContext context, AOrderDetailViewController controller) {
    List<OrderDetailModel> list = controller.listOrderDetail;
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            itemCount: controller.listOrderDetail.length,
            separatorBuilder: (_, __) => UIHelper.verticalSpace(8),
            itemBuilder: (_, index) {
              return cardProduct(list[index]);
            },
          ),
        ),
        UIHelper.verticalSpace(8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: AColor.greenBold, width: 0.3),
            ),
          ),
          child: infoBottom(),
        )
      ],
    );
  }

  Widget cardProduct(OrderDetailModel orderDetail) {
    Product product = orderDetail.product;
    double height = 80;
    return Container(
      clipBehavior: Clip.antiAlias,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: AColor.grey, width: 0.2),
        borderRadius: BorderRadius.circular(16),
        color: AColor.primary,
      ),
      child: Row(
        children: [
          AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                product.img,
                height: height,
                fit: BoxFit.fitHeight,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AText.listItem(product.title),
                  AText.body('Số lượng: ${orderDetail.quantity}'),
                  Row(
                    children: [
                      Expanded(
                        child: AText.caption(product.strPrice,
                            color: AColor.red,
                            textDecoration: TextDecoration.lineThrough),
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      AText.body(product.discountPrice, color: AColor.red),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Chi tiết hóa đơn');
  }

  Widget infoBottom() {
    return ColumnWithSpacing(
      spacing: 8,
      children: [
        textInfo(label: 'Trạng thái', widget: dropdownPicker()),
        textInfo(label: 'Thời gian đặt', widget: AText.body(controller.order.createDate)),
        textInfo(
            label: 'Tên người dùng',
            widget: AText.body(controller.infoUser.userName)),
        textInfo(
            label: 'Số điện thoại',
            widget: AText.body(controller.infoUser.phoneNumber)),
        textInfo(
          label: 'Tổng số lượng',
          widget: AText.body(controller.listOrderDetail.length.toString()),
        ),
        textInfo(
            label: 'Tổng',
            widget: AText.body(controller.tongGia.toVND(), color: AColor.red))
      ],
    );
  }

  Widget dropdownPicker() {
    return DropdownButton(
        value: controller.statusID,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: controller.listStatus
            .map((e) => DropdownMenuItem(
                  value: e.id,
                  child: AText.body(e.title),
                ))
            .toList(),
        onChanged: (v) {
          controller.updateStatus(v ?? '');
        });
  }

  Widget textInfo({required String label, required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: AText.caption('$label: '),
        ),
        UIHelper.horizontalSpace(4),
        widget
      ],
    );
  }
}
