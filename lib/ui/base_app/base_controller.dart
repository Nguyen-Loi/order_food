import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:project_order_food/core/extension/extension.dart';

abstract class BaseController extends ChangeNotifier {
  final List<Map<String, dynamic>> _data = [];

  List<Map<String, dynamic>> get data => _data;

  void clearData() {
    _data.clear();
  }

  void setData(QuerySnapshot<Object?>? value) {
    _data.clear();
    _data.addAll(value.toListMap());
  }


  void reload() {
    clearData();
    notifyListeners();
  }

  Future<QuerySnapshot?>? loadData() {
    return null;
  }

  Stream<QuerySnapshot?>? loadDataStream() {
    return null;
  }
}
