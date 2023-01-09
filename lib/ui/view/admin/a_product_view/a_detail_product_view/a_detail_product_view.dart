import 'package:flutter/material.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/admin/a_product_view/a_detail_product_view/controllers/a_detail_product_view_controller.dart';
import 'package:project_order_food/ui/widget/a_button.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';
import 'package:project_order_food/ui/widget/form/a_button_form_field.dart';
import 'package:project_order_food/core/extension/extension.dart';
import 'package:project_order_food/ui/widget/form/a_picker_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_text_form_field.dart';

class ADetailProductView extends BaseView<ADetailProductViewController> {
  ADetailProductView(Product product, {super.key})
      : super(ADetailProductViewController(product));

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget getMainView(
      BuildContext context, ADetailProductViewController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _key,
        child: ColumnWithSpacing(
          children: [
            ATextFormField(
              initValue: controller.product.title,
              label: 'Tên món ăn',
              onSaved: (p0) => controller.title = p0,
            ),
            ATextFormField(
              label: 'Giá gốc',
              keyboardType: TextInputType.number,
              initValue: controller.product.strPrice.toStrInt(),
              onSaved: (p0) => controller.price = p0,
            ),
            ATextFormField(
              label: 'Giá được giảm',
              keyboardType: TextInputType.number,
              onSaved: (p0) => controller.discountPrice = p0,
              initValue: controller.product.discountPrice.toStrInt(),
            ),
            ATextFormField(
              label: 'Mô tả',
              onSaved: (p0) => controller.description = p0,
              maxLines: null,
              initValue: controller.product.description,
            ),
            DropdownButtonFormField<Category>(
              hint: AText.body('Chọn danh mục', color: AColor.grey),
              value: controller.initCategory,
              items: controller.listCategory
                  .map((e) => DropdownMenuItem<Category>(
                      value: e, child: AText.body(e.title)))
                  .toList(),
              onSaved: (v) {
                if (v != null) {
                  controller.refID = v.id;
                } else {
                  logError('$this Null dropdown id');
                }
              },
              validator: (value) =>
                  value == null ? 'Không được để trống' : null,
              onChanged: (v) {
                controller.refID = v!.id;
              },
            ),
            APickerFormField(
              urlInit: controller.product.img,
              onSaved: (v) => controller.file = v,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget? bottomSheet(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: AButton.text(
                'Xóa',
                color: AColor.red,
                onPressed: () {
                  controller.deleteProduct();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AButtonFormField(
                _key,
                isExpanded: false,
                onValidateSuccess: () => controller.updateProduct(),
              ),
            ),
          ],
        ));
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Chi tiết');
  }
}
