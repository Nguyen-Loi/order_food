import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/base_app/base_view.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/router.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/view/admin/a_category_view/controllers/a_category_view_controller.dart';
import 'package:project_order_food/ui/widget/common_widget/a_appbar.dart';

class ACategoryView extends BaseView<ACategoryViewController> {
  ACategoryView({super.key}) : super(ACategoryViewController());

  Widget _itemCategory(Category category) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AColor.grey)),
      leading: AspectRatio(
          aspectRatio: 1, child: Image.network(category.img, fit: BoxFit.fill)),
      onTap: () {
        locator<GetNavigation>()
            .to(RoutePaths.aDetailCategorView, arguments: category);
      },
      subtitle: AText.caption(category.createDate),
      title: AText.body(category.title),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AAppbar(title: 'Danh mục');
  }

  @override
  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutePaths.aAddCategorView);
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget getMainView(BuildContext context, ACategoryViewController controller) {
    List<Category> list = controller.listCategory;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      separatorBuilder: (_, __) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (_, int index) {
        return _itemCategory(list[index]);
      },
    );
  }
}
