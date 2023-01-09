import 'package:flutter/material.dart';
import 'package:project_order_food/ui/shared/app_color.dart';

class AButton extends MaterialButton {
  AButton.text(String text,
      {bool isExpanded = false,
      super.onPressed,
      super.key,
      super.color,
      super.padding})
      : super(
            minWidth: isExpanded ? double.maxFinite : null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: AColor.black)),
            child: Text(text));

  AButton(
      {bool isExpanded = false,
      super.onPressed,
      super.key,
      super.color,
      super.padding,
      required Widget child})
      : super(
            minWidth: isExpanded ? double.maxFinite : null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: AColor.black)),
            child: child);
}
