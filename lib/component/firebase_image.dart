import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseImage extends StatefulWidget {
  const FirebaseImage({Key? key,required String filePath}) : _filePath = filePath, super(key: key);

  final String _filePath;

  @override
  State<FirebaseImage> createState() => _FirebaseImageState();
}

class _FirebaseImageState extends State<FirebaseImage> {

  File? _file;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future<void> init()async{
    final imageFile = await getImageFile();
    if (mounted) {
      setState(()  {
        _file =  imageFile;
      });
    }
  }

  Future<File?> getImageFile() async{
    final filePath = widget._filePath;
    // final storagePath = FirebaseStorage.instance.ref().child(filePath).fullPath;
    // log("+++ filePath $filePath");
    // log("+++ storagepath $storagePath");
    // final appDocDir = await getApplicationDocumentsDirectory();
    final appDocDir = await getTemporaryDirectory();
    final file = File("${appDocDir.path}/$filePath");
    // final imageUrl =
    //     await FirebaseStorage.instance.ref().child(filePath).getDownloadURL();
    // log("+++ $file");
    // log("+++ $imageUrl");
    // If the file do not exists try to download
    if (!file.existsSync()) {
      try {
        file.create(recursive: true);
        await FirebaseStorage.instance.ref(filePath).writeToFile(file);

      } catch (e) {
        // If there is an error delete the created file
        await file.delete(recursive: true);
        return null;
      }
    }
    if(await file.length()==0){
      return null;
    }
    return file;
  }

  @override
  Widget build(BuildContext context) {
    inspect(_file);
    log("+++ file"+_file.toString());
    if(_file==null){
      return const Icon(Icons.error_outline);
    }

    return Image.file(_file!, fit: BoxFit.scaleDown);
  }
}
