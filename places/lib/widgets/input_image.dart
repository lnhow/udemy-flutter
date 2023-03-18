import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class InputImage extends StatefulWidget {
  final Function(File) onSelectImageSuccess;

  const InputImage(this.onSelectImageSuccess, {super.key});

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _selectedImage;

  Future<void> _selectImage({imageSoure = ImageSource.camera}) async {
    final picker = ImagePicker();
    final xImage = await picker.pickImage(source: imageSoure, maxWidth: 600);

    if (xImage == null) {
      final LostDataResponse response = await picker.retrieveLostData();
      if (response.isEmpty) {
        return;
      }
      if (response.files != null) {
        for (final XFile file in response.files as List<XFile>) {
          _handleChangeImage(file);
        }
      } else {
        log(response.exception.toString());
      }
      return;
    }
    _handleChangeImage(xImage);
  }

  Future<void> _handleChangeImage(XFile xImage) async {
    final appDir = await syspath.getTemporaryDirectory();
    final fileName = path.basename('IMG-${DateTime.now().toIso8601String()}');
    final fileDir = path.join(appDir.path, fileName);
    try {
      await xImage.saveTo(fileDir);
      final image = File(xImage.path);
      setState(() {
        _selectedImage = image;
      });
      widget.onSelectImageSuccess(image);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEmptyImage = _selectedImage == null;
    return Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: isEmptyImage
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'No image selected',
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.file(
                  _selectedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton.icon(
            onPressed: () {
              _selectImage();
            },
            icon: const Icon(Icons.camera),
            label: const Text('Camera'))
      ],
    );
  }
}
