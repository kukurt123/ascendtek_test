import 'package:ascendtek_test/api/api_path.dart';
import 'package:ascendtek_test/model/image_model.dart';
import 'package:ascendtek_test/service/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:uuid/uuid.dart';

class MainBloc {
  final picker = ImagePicker();
  final file = BehaviorSubject<File>();
  final firestoreService = FirestoreService.instance;

  Future<firebase_storage.UploadTask> uploadImage<T>(
      {required String folderName,
      required String imageName,
      required File file,
      required String url}) async {
    late firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child('/$imageName.jpg');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    try {
      if (kIsWeb) {
        uploadTask = ref.putData(await file.readAsBytes(), metadata);
      } else {
        // if (url.isEmpty) {
        uploadTask = ref.putFile(file, metadata);
        // } else {
        // uploadTask = ref.putString(url, metadata);
        // }
      }
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return Future.error(
          "This is the error", StackTrace.fromString(e.message!));
      // return null;
    }
    return await Future.value(uploadTask);
  }

  Future<String> downloadImage(String imagePath, String folderName) async {
    final link = await firebase_storage.FirebaseStorage.instance
        .ref('$folderName/$imagePath.jpg')
        .getDownloadURL();
    return link;
  }

  pickImage({required bool isCamera}) async {
    final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      final File file2 = File(pickedFile.path);
      file.add(file2);
    }
  }

  saveImage(ImageModel img) async {
    final id = const Uuid().v4();
    const folderName = 'ascendtek_image';
    final imageSent = await uploadImage(
        folderName: folderName, file: file.value, imageName: id, url: id);
    await imageSent.then((x) async {
      final newImg = img.copyWith(url: id);
      await setImage(newImg);
    });
  }

  Future<void> setImage(
    ImageModel img,
  ) async =>
      await firestoreService.setData(
        path: AscendTekImageApi.aTekImage(img.url),
        data: img.toJson(),
      );

  final tags = [
    'Nature',
    'Selfie',
    'Office',
    'Sunset',
    'Music',
    'People',
    'Love',
    'Document',
    'Friendship',
  ].map((tag) => MultiSelectItem<String>(tag, tag)).toList();
}
