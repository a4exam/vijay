import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    super.key,
    required this.imageUrl,
    required this.onChanged,
  });

  final String imageUrl;
  final Function(File file) onChanged;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      widget.onChanged(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          _pickImage(ImageSource.gallery);
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: _image != null
                    ? Image.file(_image!)
                    : Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
