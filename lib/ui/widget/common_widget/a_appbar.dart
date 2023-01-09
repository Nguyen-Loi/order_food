import 'package:flutter/material.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';

class AAppbar extends AppBar {
  AAppbar({super.key, required String title,  Widget? suffix})
      : super(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AText.title(title, color: AColor.textWhite),
         if (suffix!=null)  suffix
        ],
      ));
}
