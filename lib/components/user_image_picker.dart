import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(Uint8List image) onImagePick;

  const UserImagePicker({
    required this.onImagePick,
    Key? key,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  Image? _image;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePickerWeb.getImageAsBytes();

    if (pickedImage != null) {
      setState(() {
        _image = Image.memory(pickedImage);
      });
      widget.onImagePick(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? _image!.image : null,
        ),
        TextButton(
          onPressed: _pickImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              const Text('Adicionar imagem'),
            ],
          ),
        ),
      ],
    );
  }
}
