import 'package:flutter/material.dart';
import 'package:project_order_food/ui/view/admin/a_category_view/a_add_category/controller/a_add_category_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';
import 'package:project_order_food/ui/widget/common_widget/with_spacing.dart';
import 'package:project_order_food/ui/widget/form/a_button_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_picker_form_field.dart';
import 'package:project_order_food/ui/widget/form/a_text_form_field.dart';

class AAddCategoryView extends StatelessWidget {
  AAddCategoryView({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AAddCategoryViewController controller = AAddCategoryViewController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(
        appBar: AAppbar(
          title: 'Thêm món ăn',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ColumnWithSpacing(
            spacing: 16,
            children: [
              ATextFormField(
                label: 'Tên danh mục',
                onSaved: (v) => controller.title = v,
              ),
              APickerFormField(
                onSaved: (v) => controller.fileImg = v,
              ),
            ],
          ),
        ),
        bottomSheet: AButtonFormField(
          _key,
          onValidateSuccess: () => controller.upload(context),
        ),
      ),
    );
  }
}
