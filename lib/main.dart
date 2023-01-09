import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/firebase_options.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/config/theme_style.dart';
import 'package:project_order_food/ui/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeStyle.data(),
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<GetNavigation>().navigatorKey,
      onGenerateRoute: MainRouter.generateRoute,
    );
  }
}
