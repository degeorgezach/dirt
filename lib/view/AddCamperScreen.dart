import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/Camper.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

class AddCamperScreen extends StatefulWidget {
  final Function(Camper) onAdd;

  AddCamperScreen({required this.onAdd});

  @override
  _AddCamperScreenState createState() => _AddCamperScreenState();
}

class _AddCamperScreenState extends State<AddCamperScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _birthdayController;
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      // Convert the picked image to File type
      _imageFile = File(pickedFile.path);

      // Optionally, you can resize the image using the 'image' package
      img.Image? image = img.decodeImage(_imageFile!.readAsBytesSync());
      //img.Image resizedImage = img.copyResize(image!, width: 100);

      // Save the resized image back to File
      //_imageFile =
      //    File.fromRawPath(Uint8List.fromList(img.encodePng(resizedImage)));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _birthdayController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Camper'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              final String formatted = formatter.format(DateTime.now());

              widget.onAdd(
                Camper(
                  firstName: _firstNameController.text,
                  birthday: formatted,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name:'),
            TextField(controller: _firstNameController),
            SizedBox(height: 16.0),
            Text('Date of Birth:'),
            TextFormField(
              controller: _birthdayController,
              decoration: InputDecoration(
                labelText: 'Selected Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              onTap: () => _selectDate(context),
            ),
            _imageFile != null
                ? Image.file(_imageFile!, width: 100, height: 100)
                : Placeholder(
              fallbackHeight: 20,
              fallbackWidth: 20,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text('Take Photo'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Pick from Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String formatted = formatter.format(selectedDate);

        _birthdayController.text = formatted;
      });
    }
  }
}