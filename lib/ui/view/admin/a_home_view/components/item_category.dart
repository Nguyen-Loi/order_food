import 'package:flutter/material.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';

class ItemCategoryModel {
  final String title;
  final String strAsset;
  final Function() onTap;
  ItemCategoryModel({
    required this.title,
    required this.strAsset,
    required this.onTap,
  });
}

class ItemCategory extends StatelessWidget {
  const ItemCategory(this.model, {super.key});
  final ItemCategoryModel model;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: AColor.grey,
        title: AText.body(model.title),
      ),
      child:
          InkResponse(onTap: model.onTap, child: Image.asset(model.strAsset)),
    );
  }
}
