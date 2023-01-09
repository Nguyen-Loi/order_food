import 'package:flutter/material.dart';
import 'package:project_order_food/ui/shared/app_color.dart';

class ThemeStyle {
  static ThemeData data() {
    return ThemeData(
        primaryColor: AColor.primary,
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(
          buttonColor: AColor.greenBold, //  <-- dark color
          textTheme:
              ButtonTextTheme.primary, //  <-- this auto selects the right color
        ),
        backgroundColor: AColor.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: AColor.greenBold
        ),
        scaffoldBackgroundColor: AColor.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardColor: AColor.cardColor);
  }
}
