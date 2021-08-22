import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;

import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.grey[300],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
dynamic bytes;

class FileUploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: raisedButtonStyle,
      child: Text('Hãy nhập ảnh'),
      onPressed: () async {
        XFile? _getImg = await pickImg();

        if (_getImg != null) {
          constant.imageUrl = _getImg.path;
          bytes = await _getImg.readAsBytes();

          Get.snackbar('Thông báo', 'Nhập hình thành công',
              duration: Duration(seconds: 4),
              animationDuration: Duration(milliseconds: 800),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white);
        } else {
          Get.snackbar('Thông báo', 'Nhập thất bại',
              duration: Duration(seconds: 4),
              animationDuration: Duration(milliseconds: 800),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white);
        }
      },
    );
  }
}

Future<fb_storage.TaskSnapshot?> uploadFile(context, String imgPath) async {
  try {
    fb_storage.FirebaseStorage storage = fb_storage.FirebaseStorage.instance;

    if (imgPath.isNotEmpty) {
      var uniqueId = Uuid().v1();

      fb_storage.TaskSnapshot av =
          await storage.ref().child("avatar/$uniqueId").putData(bytes);

      return av;
    }
    return null;
  } catch (e) {
    throw e;
  }
}

Future<XFile?> pickImg() async {
  return await _pickByGallary();
}

Future<XFile?> _pickByGallary() async {
  final ImagePicker _picker = ImagePicker();
  return await _picker.pickImage(source: ImageSource.gallery);
}
