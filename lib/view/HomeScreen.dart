import 'package:flutter/material.dart';
import 'CamperListScreen.dart';
import 'CampScheduleScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skate Camp Midwest'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: <Widget>[
          _buildTile(context, 'Camper List', Icons.group, CamperListScreen()),
          _buildTile(context, 'Camp Schedule', Icons.calendar_month, CampScheduleScreen()),
          // Add more tiles for other screens if needed
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Card(
        elevation: 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50.0, color: Colors.green),
            SizedBox(height: 8.0),
            Text(title, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}