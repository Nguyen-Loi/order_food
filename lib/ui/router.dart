import 'package:flutter/material.dart';
import 'package:project_order_food/core/model/category.dart';
import 'package:project_order_food/core/model/order_model.dart';
import 'package:project_order_food/core/model/product.dart';
import 'package:project_order_food/core/model/user_app.dart';
import 'package:project_order_food/ui/view/admin/a_category_view/a_add_category/a_add_category_view.dart';
import 'package:project_order_food/ui/view/admin/a_category_view/a_category_view.dart';
import 'package:project_order_food/ui/view/admin/a_category_view/a_detail_category/a_detail_category_view.dart';
import 'package:project_order_food/ui/view/admin/a_home_view/a_home_view.dart';
import 'package:project_order_food/ui/view/admin/a_order_view/a_order_detail_view/a_order_detail_view.dart';
import 'package:project_order_food/ui/view/admin/a_order_view/a_order_view.dart';
import 'package:project_order_food/ui/view/admin/a_product_view/a_add_product_view/a_add_product_view.dart';
import 'package:project_order_food/ui/view/admin/a_product_view/a_detail_product_view/a_detail_product_view.dart';
import 'package:project_order_food/ui/view/admin/a_product_view/a_product_view.dart';
import 'package:project_order_food/ui/view/admin/a_user_view/a_user_detail_view/a_detail_user_view.dart';
import 'package:project_order_food/ui/view/admin/a_user_view/a_user_view.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/loading_view.dart';
import 'package:project_order_food/ui/view/common_view/login/login_view.dart';
import 'package:project_order_food/ui/view/common_view/register/register_view.dart';
import 'package:project_order_food/ui/view/user/u_cart_view/u_cart_view.dart';
import 'package:project_order_food/ui/view/user/u_category_view/u_category_view.dart';
import 'package:project_order_food/ui/view/user/u_detail_product_view/u_detail_product_view.dart';
import 'package:project_order_food/ui/view/user/u_home_view/u_home_view.dart';
import 'package:project_order_food/ui/view/user/u_order_view/u_detail_order_view/u_detail_order_view.dart';
import 'package:project_order_food/ui/view/user/u_order_view/u_order_view.dart';
import 'package:project_order_food/ui/view/user/u_profile_view/u_profile_view.dart';

class RoutePaths {
  RoutePaths._();
  static const aHomeView = '/a';

  static const loadingView = '/loading';

  static const loginView = '/';
  static const registerView = '/register';

  static const aCategorView = '/a_category';
  static const aAddCategorView = '$aCategorView/a_add_category';
  static const aDetailCategorView = '$aCategorView/a_detail_category';

  static const aProductView = '/a_product';
  static const aAddProductView = '$aProductView/a_add_product';
  static const aADetailProductView = '$aProductView/a_detail_product';

  static const aUserView = '/a_user';
  static const aDetailUserView = '$aUserView/a_detail_user';

  static const aOrderView = '/a_order';
  static const aOrderDetailView = '$aOrderView/a_order_detail';

  ///User
  static const uHomeView = '/u';

  static const uDetailProductView = '$uHomeView/u_detail_product';
  static const uCartView = '$uHomeView/u_cart';
  static const uOrderView = '$uHomeView/u_order';
  static const uProfileView = '$uHomeView/u_profile';
  static const uCategoryView = '$uHomeView/u_category';
  static const uDetailOrderView = '$uHomeView/u_detail_order';
}

class ANavigator {
  ANavigator._();
}

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.loadingView:
        return MaterialPageRoute(builder: (_) => const LoadingView());

      case RoutePaths.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RoutePaths.registerView:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case RoutePaths.aHomeView:
        return MaterialPageRoute(builder: (_) => const AHomeView());
      case RoutePaths.aCategorView:
        return MaterialPageRoute(builder: (_) => ACategoryView());
      case RoutePaths.aAddCategorView:
        return MaterialPageRoute(builder: (_) => AAddCategoryView());
      case RoutePaths.aDetailCategorView:
        Category category = settings.arguments as Category;
        return MaterialPageRoute(builder: (_) => ADetailCategoryView(category));
      case RoutePaths.aProductView:
        return MaterialPageRoute(builder: (_) => AProductView());
      case RoutePaths.aAddProductView:
        return MaterialPageRoute(builder: (_) => AAddProductView());
      case RoutePaths.aADetailProductView:
        Product product = settings.arguments as Product;
        return MaterialPageRoute(builder: (_) => ADetailProductView(product));
      case RoutePaths.aUserView:
        return MaterialPageRoute(builder: (_) => AUserView());
      case RoutePaths.aDetailUserView:
        UserApp user = settings.arguments as UserApp;
        return MaterialPageRoute(builder: (_) => ADetailUserView(user: user));
      case RoutePaths.aOrderView:
        return MaterialPageRoute(builder: (_) => AOrderView());
      case RoutePaths.aOrderDetailView:
        OrderModel order = settings.arguments as OrderModel;
        return MaterialPageRoute(
            builder: (_) => AOrderDetailView(
                  orderModel: order,
                ));

      //User
      case RoutePaths.uHomeView:
        return MaterialPageRoute(builder: (_) => UHomeView());
      case RoutePaths.uCartView:
        return MaterialPageRoute(builder: (_) => UCartView());
      case RoutePaths.uOrderView:
        return MaterialPageRoute(builder: (_) => UOrderView());
      case RoutePaths.uProfileView:
        return MaterialPageRoute(builder: (_) => UProfileView());
      case RoutePaths.uCategoryView:
        return MaterialPageRoute(builder: (_) => UCategoryView());

      case RoutePaths.uDetailOrderView:
        String orderID = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => UDetailOrderView(orderID: orderID));
      case RoutePaths.uDetailProductView:
        Product product = settings.arguments as Product;

        return MaterialPageRoute(
            builder: (_) => UDetailProductView(
                  model: product,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
