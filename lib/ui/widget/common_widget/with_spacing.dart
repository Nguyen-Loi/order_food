import 'package:flutter/cupertino.dart';

class ColumnWithSpacing extends Column {
  ColumnWithSpacing(
      {super.crossAxisAlignment,
      super.key,
      super.mainAxisAlignment,
      super.mainAxisSize,
      super.textBaseline,
      super.textDirection,
      super.verticalDirection,
      double spacing = 16,
      List<Widget> children = const <Widget>[]})
      : super(
          children: children.insertBetweenAll(
            SizedBox(height: spacing),
          ),
        );
}


class RowWithSpacing extends Row{
   RowWithSpacing(
      {super.crossAxisAlignment,
      super.key,
      super.mainAxisAlignment,
      super.mainAxisSize,
      super.textBaseline,
      super.textDirection,
      super.verticalDirection,
      double spacing = 16,
      List<Widget> children = const <Widget>[]})
      : super(
          children: children.insertBetweenAll(
            SizedBox(width: spacing),
          ),
        );
}

extension on List<Widget> {
  List<Widget> insertBetweenAll(Widget widget) {
    var result = List<Widget>.empty(growable: true);
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) {
        result.add(widget);
      }
    }
    return result;
  }
}
