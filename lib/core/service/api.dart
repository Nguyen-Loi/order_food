import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/model/field_name.dart';

class Api {
  Api(this.pathCollection) {
    ref = FirebaseFirestore.instance.collection(pathCollection);
  }
  final String pathCollection;
  late CollectionReference ref;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<String?> removeDocument(String id) async {
    try {
      await ref.doc(id).delete();
      logSuccess('Xóa data thành công: $pathCollection');
      return null;
    } catch (e) {
      logSuccess('Xóa dữ liệu thất bại: $pathCollection');
      return 'Xóa dữ liệu thất bại';
    }
  }

  Future<String?> addDocument(Map data, {File? file, String? customID}) async {
    if (file != null) {
      String pathFile =
          '$pathCollection/${DateTime.now()}_${basename(file.path)}';

      try {
        String url = await _uploadFile(file, pathFile: pathFile);
        data['img'] = url;
        logSuccess('Upload file thành công: $url');
      } catch (e) {
        logError('Upload file không thành công: $e');
      }
    }

    try {
      Map<String, Object> newData = Map.from({
        ...data,
        ...{FieldName.createDate: DateTime.now()}
      });
      if (customID == null) {
        ref.add(newData);
      } else {
        ref.doc(customID).set(newData);
      }

      logSuccess('Thêm data thành công vào bảng $pathCollection');
      return null;
    } catch (e) {
      logError('Thêm data thất bại: $e');
      return 'Đã có lỗi xãy ra';
    }
  }

  Future<String?> updateDocument(Map data, String id, {File? file}) async {
    //Conditon file is not null => replace new image
    try {
      if (file != null) {
        try {
          //Remove file
          String currentDirectory =
              '$pathCollection/${FirebaseStorage.instance.refFromURL(data['img'] as String).name}';
          await storage.ref().child(currentDirectory).delete();
          //upload new file

          String pathFile =
              '$pathCollection/${DateTime.now()}_${basename(file.path)}';
          String url = await _uploadFile(file, pathFile: pathFile);
          data['img'] = url;
          data[FieldName.updateDate] = DateTime.now();
          logSuccess('Cập nhật ảnh mới thành công');
        } catch (e) {
          logError(
              'Cập nhât ảnh mới thất bại: Có thể do đường dẫn ảnh (img) không có trong data $e');
        }
      }
      await ref.doc(id).update(Map.from(data));
      return null;
    } catch (e) {
      logError('Có lỗi xãy ra khi cập nhật thông tin: $e');
      return 'Có lỗi xãy ra khi cập nhật thông tin';
    }
  }

  Future<String> _uploadFile(File file, {required String pathFile}) async {
    UploadTask uploadTask = storage.ref(pathFile).putFile(file);
    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }
}
