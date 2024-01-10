import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/Camper.dart';
import 'package:intl/intl.dart';

class CamperDetailScreen extends StatefulWidget {
  final Camper camper;
  final Function(Camper) onUpdate;
  final Function(int) onDelete;

  CamperDetailScreen({
    required this.camper,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  _CamperDetailScreenState createState() => _CamperDetailScreenState();
}

class _CamperDetailScreenState extends State<CamperDetailScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _birthdayController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.camper.firstName);

    DateTime date = DateTime.parse(widget.camper.birthday);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    _birthdayController = TextEditingController(text: formatted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camper Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.onUpdate(
                Camper(
                  id: widget.camper.id,
                  firstName: _firstNameController.text,
                  birthday: _birthdayController.text,
                ),
              );
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.onDelete(widget.camper.id!);
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
            TextField(controller: _birthdayController),
          ],
        ),
      ),
    );
  }
}