import 'package:flutter/widgets.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/widget/a_button.dart';

class AButtonFormField extends StatelessWidget {
  final GlobalKey<FormState> keyForm;
  final Color? color;
  final String tille;
  final bool isExpanded;
  final EdgeInsets? padding;
  final VoidCallback onValidateSuccess;
  final VoidCallback onFailedValidate;

  AButtonFormField(
    this.keyForm, {
    super.key,
    this.color,
    VoidCallback? onValidateSuccess,
    VoidCallback? onFailedValidate,
    this.tille = 'Xác nhận',
    this.padding,
    this.isExpanded = true,
  })  : onValidateSuccess = onValidateSuccess ?? (() {}),
        onFailedValidate = onFailedValidate ?? (() {});

  @override
  Widget build(BuildContext context) {
    return AButton.text(
      tille,
      padding: padding,
      color: color ?? AColor.greenBold,
      isExpanded: isExpanded,
      onPressed: () {
        if (keyForm.currentState!.validate()) {
          keyForm.currentState?.save();
          onValidateSuccess();
          logSuccess('Xác nhận form hợp lệ');
        } else {
          onFailedValidate();
          logError('Xác nhận form không hợp lệ');
        }
      },
    );
  }
}
