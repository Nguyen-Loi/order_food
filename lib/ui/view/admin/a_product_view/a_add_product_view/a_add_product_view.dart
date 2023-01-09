import 'package:flutter/material.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/admin/a_product_view/a_add_product_view/controllers/a_add_product_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';
import 'package:project_order_food/ui/widget/form/a_button_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_picker_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_text_form_field.dart';

class AAddProductView extends BaseView<AAddProductViewController> {
  AAddProductView({super.key}) : super(AAddProductViewController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget getMainView(
      BuildContext context, AAddProductViewController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _key,
        child: ColumnWithSpacing(
          children: [
            ATextFormField(
              label: 'Tên món ăn',
              onSaved: (p0) => controller.title = p0,
            ),
            ATextFormField(
              label: 'Giá gốc',
              keyboardType: TextInputType.number,
              onSaved: (p0) => controller.price = p0,
            ),
            ATextFormField(
              label: 'Giá được giảm',
              keyboardType: TextInputType.number,
              onSaved: (p0) => controller.discountPrice = p0,
            ),
            ATextFormField(
              label: 'Mô tả',
              onSaved: (p0) => controller.description = p0,
            ),
            DropdownButtonFormField<Category>(
              hint: AText.body('Chọn danh mục', color: AColor.grey),
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
              onSaved: (v) => controller.file = v,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget? bottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: AButtonFormField(
        _key,
        onValidateSuccess: () {
          controller.addProduct();
        },
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Thêm');
  }
}
