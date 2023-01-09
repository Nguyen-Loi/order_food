import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'extension.dart';

extension Find<K, V, R> on Map<K, V> {
  ///Return the string
  R find(K key, R Function(String value) cast, {Object? defaultValue}) {
    try {
      final value = this[key];
      if (value != null) {
        return cast(value.toString());
      } else {
        if (defaultValue != null) {
          return cast(defaultValue.toString());
        }
      }
    } catch (_) {
      return cast(defaultValue.toString());
    }
    return cast(defaultValue.toString());
  }

  ///Return by dataType
  R findData<T>(K key, R Function(T value) cast, {Object? defaultValue}) {
    R defaultTemp = cast(defaultValue as T);
    try {
      final value = this[key];
      if (value != null && value is T) {
        return cast(value as T);
      } else {
        if (defaultValue != null) {
          return defaultTemp;
        }
      }
    } catch (_) {
      return defaultTemp;
    }
    return defaultTemp;
  }
}

class Methods {
  Methods._();
  static double getDouble(Map data, String fieldName,
      {double defaultValue = 0.0}) {
    return data.find(fieldName, (value) => double.parse(value),
        defaultValue: defaultValue);
  }

  static dynamic getMap(Map data, String fieldName, {dynamic defaultValue}) {
    return data.findData(fieldName, (value) => value,
        defaultValue: defaultValue);
  }

  static int getInt(Map data, String fieldName, {int defaultValue = 0}) {
    return data.find(fieldName, (value) => double.parse(value).toInt(),
        defaultValue: defaultValue);
  }

  static int getIntRound(Map data, String fieldName, {int defaultValue = 0}) {
    return data.find(fieldName, (value) => double.parse(value).round(),
        defaultValue: defaultValue);
  }

  static String getString(Map data, String fieldName,
      {String defaultValue = ''}) {
    return data.find(fieldName, (value) => value, defaultValue: defaultValue);
  }

  static bool getBool(Map data, String fieldName, {bool defaultValue = false}) {
    return data.find(fieldName, (value) {
      if (value == 'true' || value == '1') {
        return true;
      }
      return false;
    });
  }

  static String getPriceVND(Map data, String fieldName,
      {bool defaultValue = false}) {
    return data.find(fieldName, (value) {
      return value.toVND();
    });
  }

  static DateTime getDateTime(Map data, String fieldName,
      {DateTime? defaultValue}) {
    return data.findData(fieldName, (value) {
      if (value is Timestamp) {
        return value.toDate();
      }
    }, defaultValue: defaultValue ?? DateTime(1, 1, 1, 1, 1));
  }

  static String convertTime(DateTime dateTime,
      {String defaultFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateFormat(defaultFormat).format(dateTime);
  }

  static List getList(Map data, String fieldName) {
    return data.findData(fieldName, (value) => value, defaultValue: []);
  }

  ///String => int
  static int convertToInt(Map data, String fieldName) {
    return data.find(
        fieldName, (value) => value.replaceAll(RegExp(r'[^0-9]'), ''));
  }
}
