import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:sanogano/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  Reference _storageReference;

  StorageServices() {
    _storageReference = FirebaseStorage.instance.ref();
  }

  



  Future<String> uploadStoryImage(String filePath) async {
     String _extension = p.extension(filePath);
    String fileName = createCryptoRandomString(8) + _extension;
    final UploadTask uploadTask =
        _storageReference.child("Stories" + '/' + fileName).putFile(
              File(filePath),
              
              SettableMetadata(
                contentType: "image",
              ),
            );

    final TaskSnapshot downloadUrl = await uploadTask;
    final String profileUrl = await downloadUrl.ref.getDownloadURL();

    return profileUrl;
  }
}
