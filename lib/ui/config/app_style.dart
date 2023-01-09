import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_order_food/ui/shared/app_color.dart';

class ATextStyle {
  static TextStyle body({TextDecoration? textDecoration, Color? color}) {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        decoration: textDecoration,
        color: color ?? AColor.black);
  }

  static TextStyle caption({TextDecoration? textDecoration, Color? color}) {
    return TextStyle(
        fontSize: 12,
        decoration: textDecoration,
        fontWeight: FontWeight.bold,
        color: color ?? AColor.black);
  }
}

class AText {
  static Text custom(String text, {TextStyle? textStyle}) {
    return Text(
      text,
      style: textStyle,
    );
  }

  ///Chữ dành cho appBar hoặc title (Lớn)
  static Text title(
    String text, {
    Color? color,
  }) {
    return Text(text,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? AColor.black));
  }

  ///Chữ dành cho title lớn
  static Text listItem(
    String text, {
    Color? color,
  }) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color ?? AColor.black));
  }

  ///Font chữ bình thường
  static Text body(
    String text, {
    Color? color,
    int? maxLines = 1,
    TextDecoration? textDecoration,
    TextAlign? textAlign,
  }) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.clip,
        style: ATextStyle.body(textDecoration: textDecoration, color: color));
  }

  ///Font chữ nhỏ
  static Text caption(
    String text, {
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            ATextStyle.caption(color: color, textDecoration: textDecoration));
  }
}
