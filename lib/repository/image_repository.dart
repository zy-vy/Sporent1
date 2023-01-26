import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ImageRepository {
  final storage = FirebaseStorage.instance.ref();

  Future<void> uploadFile(String path, String name, File file) async {
    var fileRef = storage.child("$path/").child(name);
    fileRef
        .putFile(file)
        .then((p0) =>
        // log("Success upload $name")
    )
        .onError((error, stackTrace) => log("$error |\n $stackTrace"));
  }

  Future<File?> getImageFile(String filePath) async {
    final appDocDir = await getTemporaryDirectory();
    final file = File("${appDocDir.path}/$filePath");

    if (!file.existsSync()) {
      try {
        file.create(recursive: true);
        await FirebaseStorage.instance.ref(filePath).writeToFile(file);
      } catch (e) {
        await file.delete(recursive: true);
        return null;
      }
    }
    if (await file.length() == 0) {
      return null;
    }
    return file;
  }
}
