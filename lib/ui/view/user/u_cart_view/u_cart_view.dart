import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/cart_product.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/ui/view/user/u_cart_view/controller/u_cart_view_controller.dart';
import 'package:project_order_food/ui/widget/a_button.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';
import 'package:project_order_food/core/extension/extension.dart';
import 'package:project_order_food/ui/widget/dialog/a_dialog.dart';

class UCartView extends BaseView<UCartViewController> {
  UCartView({super.key}) : super(UCartViewController());

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(
      title: 'Giỏ hàng',
      suffix: IconButton(
        onPressed: () {
          controller.clearAll();
        },
        icon: const Icon(
          Icons.delete,
        ),
      ),
    );
  }

  Widget bottom() {
    return controller.listCartProduct.isNotEmpty
        ? ColoredBox(
            color: AColor.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ColumnWithSpacing(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  rowTextBottomSheet(),
                  AButton.text(
                    'Thanh toán',
                    isExpanded: true,
                    onPressed: () {
                      if (locator<DataApp>().user.phoneNumber.isEmpty) {
                        locator<GetNavigation>().openDialog(
                            typeDialog: TypeDialog.waring,
                            content: 'Bạn cần điền thông tin để thanh toán',
                            onSubmit: () {
                              locator<GetNavigation>()
                                  .replaceTo(RoutePaths.uProfileView);
                            });
                      } else {
                        controller.checkout();
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget rowTextBottomSheet() {
    return Row(
      children: [
        Expanded(
          child: AText.caption('Tổng thanh toán'),
        ),
        const SizedBox(width: 4),
        AText.body(controller.tongGia.toVND(), color: AColor.red)
      ],
    );
  }

  @override
  Widget getMainView(BuildContext context, UCartViewController controller) {
    List<CartProduct> list = controller.listCartProduct;
    return list.isEmpty
        ? Center(
            child: AText.listItem('Bạn không có món ăn trong giỏ hàng'),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (__, _) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (_, int index) {
                    return card(list[index]);
                  },
                ),
              ),
              bottom()
            ],
          );
  }

  Widget card(CartProduct model) {
    return GestureDetector(
      onTap: () {
        locator<GetNavigation>()
            .to(RoutePaths.uDetailProductView, arguments: model.product);
      },
      child: Container(
        height: 120,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: AColor.primary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AColor.grey)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AspectRatio(
              aspectRatio: 7 / 6,
              child: Image.network(
                model.product.img,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AText.listItem(model.product.title),
                    Row(
                      children: [
                        Expanded(
                          child: AText.caption(
                            model.product.strPrice,
                            color: AColor.red,
                            textDecoration: TextDecoration.lineThrough,
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        AText.body(model.product.discountPrice, color: AColor.red),
                      ],
                    ),
                    //Button
                    RowWithSpacing(
                      spacing: 3,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.removeItem(model.product.id);
                          },
                          icon: Icon(
                            Icons.remove,
                            color: AColor.greenBold,
                          ),
                        ),
                        AText.body(model.cart.quantity.toString(),
                            color: AColor.black),
                        IconButton(
                          onPressed: () {
                            controller.addItem(model.product.id);
                          },
                          icon: Icon(
                            Icons.add,
                            color: AColor.greenBold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
