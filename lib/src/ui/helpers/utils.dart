import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning }

void showSnackBar({
  required BuildContext context,
  required String text,
  SnackBarType type = SnackBarType.success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: switch (type) {
        SnackBarType.success => Colors.green,
        SnackBarType.error => Colors.red,
        SnackBarType.warning => Colors.orange,
      },
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = <File>[];
  try {
    FilePickerResult? pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (pickerResult != null && pickerResult.files.isNotEmpty) {
      for (int i = 0; i < pickerResult.files.length; i++) {
        images.add(File(pickerResult.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
