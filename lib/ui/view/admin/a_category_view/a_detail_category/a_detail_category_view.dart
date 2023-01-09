import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/admin/a_category_view/a_detail_category/controllers/a_detail_category_controller.dart';
import 'package:project_order_food/ui/widget/a_button.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';
import 'package:project_order_food/ui/widget/form/a_button_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_picker_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_text_form_field.dart';

class ADetailCategoryView extends BaseView<ADetailCategoryController> {
  ADetailCategoryView(this.category, {super.key})
      : super(ADetailCategoryController(category));

  final Category category;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Chi tiết danh mục');
  }

  @override
  Widget getMainView(
      BuildContext context, ADetailCategoryController controller) {
    return ColumnWithSpacing(
      children: [
        Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ColumnWithSpacing(
              spacing: 16,
              children: [
                ATextFormField(
                  initValue: category.title,
                  label: 'Tên danh mục',
                  onSaved: (v) => controller.title = v,
                ),
                APickerFormField(
                  urlInit: category.img,
                  onSaved: (v) => controller.file = v,
                ),
              ],
            ),
          ),
        )
      ],
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
                  controller.deleteCategory();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AButtonFormField(
                _key,
                isExpanded: false,
                onValidateSuccess: () => controller.updateFile(),
              ),
            ),
          ],
        ));
  }
}
