import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/user/u_detail_product_view/controller/u_detail_product_view_controller.dart';
import 'package:project_order_food/ui/widget/a_button.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';

class UDetailProductView extends BaseView<UDetailViewController> {
  UDetailProductView({required this.model, super.key})
      : super(UDetailViewController());

  final Product model;

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(
      title: 'Thông tin chi tiết',
    );
  }

  @override
  Widget? bottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: AButton(
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.card_travel_outlined),
              UIHelper.horizontalSpace(4),
              AText.body('Thêm vào giỏ', color: AColor.white),
            ],
          ),
        ),
        onPressed: () {
          controller.addCard(model.id);
        },
      ),
    );
  }

  @override
  Widget getMainView(BuildContext context, UDetailViewController controller) {
    return ListView(
      children: [
        banner(),
        Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              UIHelper.verticalSpace(4),
              rowPrice(),
              UIHelper.verticalSpace(4),
              description(),
            ],
          ),
        )
      ],
    );
  }

  Widget rowPrice() {
    return Row(
      children: [
        AText.body(model.discountPrice, color: AColor.red),
        UIHelper.horizontalSpace(4),
        AText.caption(model.strPrice,
            color: AColor.red, textDecoration: TextDecoration.lineThrough),
      ],
    );
  }

  Widget description() {
    return AText.body(model.description, maxLines: null);
  }

  Widget get title => AText.listItem(model.title);

  Widget banner() {
    return Hero(
      tag: model.id,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(model.img),
          ),
        ),
      ),
    );
  }
}
