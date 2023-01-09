import 'package:flutter/material.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/widget/a_button.dart';

enum TypeDialog { waring, ask, sucesss, error }

class ADialog {
  static void show(BuildContext context,
      {String? title,
      TypeDialog typeDialog = TypeDialog.error,
      String? content,
      Function()? onClose,
      Function()? onSubmit}) {
    showDialog(
        context: context,
        builder: ((context) => BaseADialog(
              content: content,
              onClose: onClose,
              onSubmit: onSubmit,
              title: title,
              typeDialog: typeDialog,
            )));
  }
}

class BaseADialog extends StatelessWidget {
  final String? title;
  final TypeDialog typeDialog;
  final String? content;
  final Function()? onClose;
  final Function()? onSubmit;

  const BaseADialog(
      {super.key,
      this.title,
      this.typeDialog = TypeDialog.error,
      this.content,
      this.onClose,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          iconDefault,
          const SizedBox(width: 8),
          AText.title(title ?? textDefalt.keys.first),
        ],
      ),
      content: AText.body(content ?? textDefalt.values.first, maxLines: null),
      actions: [
        AButton.text(
          'Đóng',
          color: AColor.red,
          onPressed: onClose ?? () => Navigator.pop(context),
        ),
        if (onSubmit != null)
          AButton.text(
            'Xác nhận',
            color: AColor.greenBold,
            onPressed: onSubmit,
          ),
      ],
    );
  }
}

extension DefaultValueDialog on BaseADialog {
  Icon get iconDefault {
    switch (typeDialog) {
      case TypeDialog.waring:
        return Icon(
          Icons.warning,
          color: AColor.yellow,
        );
      case TypeDialog.ask:
        return Icon(
          Icons.question_mark,
          color: AColor.primary,
        );
      case TypeDialog.sucesss:
        return Icon(
          Icons.check,
          color: AColor.greenBold,
        );
      case TypeDialog.error:
        return Icon(
          Icons.close,
          color: AColor.red,
        );
    }
  }

  Map<String, String> get textDefalt {
    switch (typeDialog) {
      case TypeDialog.waring:
        return {'Cảnh báo': 'Chức năng không phù hợp'};
      case TypeDialog.ask:
        return {'Xác nhận': 'Bạn xác nhận thay đổi không'};
      case TypeDialog.sucesss:
        return {'Thành công': 'Chức năng đã được thực hiện'};
      case TypeDialog.error:
        return {'Lỗi': 'Đã có vấn đề xãy ra'};
    }
  }
}
