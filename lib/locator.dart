import 'package:get_it/get_it.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';
import 'package:project_order_food/core/service/get_navigation.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GetNavigation());
  locator.registerLazySingleton(() => DataApp());
}
