import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomTextFieldWithImage extends StatefulWidget {
  const CustomTextFieldWithImage({
    super.key,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.minLines,
    required this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.onTap,
  });

  final String? hintText;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  final bool readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool enabled;
  final Function? onTap;
  final Function? suffixIconOnPressed;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  State<CustomTextFieldWithImage> createState() =>
      _CustomTextFieldWithImageState();
}

class _CustomTextFieldWithImageState extends State<CustomTextFieldWithImage> {
  File? _image;

  Future _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image != null
              ? Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _image!,
                            height: 100.0,
                          )),
                    ),
                    Positioned(
                      right: -20,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
          TextField(
            controller: widget.controller,
            cursorColor: Colors.transparent,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: Colors.transparent,
              suffixIcon: IconButton(
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: _pickImage,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
