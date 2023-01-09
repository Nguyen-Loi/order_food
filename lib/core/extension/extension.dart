import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';

extension CallBackAPI on String? {
  //Đúng thì quay vè màn hình trước dó không thì thông báo
  void backOrNotification() {
    if (this == null) {
      locator<GetNavigation>().back();
    } else {
      locator<GetNavigation>().openDialog(content: this);
    }
  }
}

extension QuerySnapshotToList on QuerySnapshot<Object?>? {
  //Đúng thì quay vè màn hình trước dó không thì thông báo
  List<Map<String, dynamic>> toListMap() {
    List<Map<String, dynamic>> temp = [];
    if (this != null) {
      for (var e in this!.docs) {
        Map<String, dynamic> currentValue = e.data() as Map<String, dynamic>;
        currentValue['id'] = e.id;
        temp.add(currentValue);
      }
    }
    return temp;
  }
}

extension FormatCurrencyEx on dynamic {
  String toVND({String? unit = 'đ'}) {
    int number = int.parse(toString());
    var vietNamFormatCurrency =
        NumberFormat.currency(locale: "vi-VN", symbol: unit);
    return vietNamFormatCurrency.format(number);
  }

  ///'1231 abc' -> '1231
  String toStrInt() {
    return this.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

extension HandleMap<K, V> on Map<K, V> {
  Map<K, V> addAllNotNull(Map<K, V> newValue) {
    Map<K, V> mValue = this;
    Map<K, V> mapNotNull = Map.fromIterable(newValue.entries.map((e) {
      if (e.value != null) {
        return e;
      }
    }));
    mValue.addAll(mapNotNull);
    return mValue;
  }
}
