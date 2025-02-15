import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:transfer/utils/constant_strings.dart';

import '../utils/local_storage.dart';

class NidVerificationProvider extends ChangeNotifier {
  File? frontPartImage;
  File? backPartImage;
  File? ownImage;
  final ImagePicker _picker = ImagePicker();
  final LocalStorage _localStorage = LocalStorage();

  Future<File?> selectPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      return file;
    }
    return null;
  }

  Future<void> selectFrontPartImage() async {
    frontPartImage = await selectPhoto();
    notifyListeners();
  }

  void clearFrontPartImage() {
    frontPartImage = null;
    notifyListeners();
  }

  Future<void> selectBackPartImage() async {
    backPartImage = await selectPhoto();
    notifyListeners();
  }

  void clearBackPartImage() {
    backPartImage = null;
    notifyListeners();
  }

  Future<void> selectOwnImage() async {
    ownImage = await selectPhoto();
    notifyListeners();
  }

  void clearOwnImage() {
    ownImage = null;
    notifyListeners();
  }

  String fileName(File file) {
    return file.path.split('/').last ?? "";
  }

  Future<http.Response?> uploadNid() async {
    final requester =
        http.MultipartRequest('POST', Uri.parse(baseUrl + nidUploadEp));

    if (kDebugMode) {
      debugPrint(baseUrl + nidUploadEp);
    }
    String token = _localStorage.token;
    if (frontPartImage != null) {
      requester.files.add(await http.MultipartFile.fromPath(
        "front",
        frontPartImage?.path ?? "",
      ));
    }

    if (backPartImage != null) {
      requester.files.add(await http.MultipartFile.fromPath(
        "back",
        backPartImage?.path ?? "",
      ));
    }

    if (ownImage != null) {
      requester.files.add(await http.MultipartFile.fromPath(
        "own",
        ownImage?.path ?? "",
      ));
    }

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    requester.headers.addAll(headers);
    http.Response res;
    try {
      http.StreamedResponse response = await requester.send();
      res = await http.Response.fromStream(response);
      return res;
    } catch (err) {
      if (kDebugMode) {
        log("Uploading NID failed - $err");
      }
      return null;
    }
  }
}
