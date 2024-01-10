import 'package:flutter/material.dart';

class CampScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camp Schedule'),
      ),
      body: Center(

      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CampScheduleScreen(),
  ));
}