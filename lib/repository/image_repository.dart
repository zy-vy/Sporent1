import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageRepository{

  final storage = FirebaseStorage.instance.ref();

  Future<void> uploadFile(String path, String name,File file) async {
    var fileRef = storage.child("$path/").child(name);
    var pos = file.path.lastIndexOf('.');
    String result = (pos != -1)? file.path.substring(pos, file.path.length): file.path;
    name += result;
    fileRef.putFile(file).then((p0) => log("Success upload $name")).onError((error, stackTrace) => log("$error |\n $stackTrace"));
  }
}