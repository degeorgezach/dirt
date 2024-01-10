import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/Camper.dart';
import '../view/CamperDetailScreen.dart';
import '../view/AddCamperScreen.dart';

class CamperListScreen extends StatefulWidget {
  @override
  _CamperListScreenState createState() => _CamperListScreenState();
}

class _CamperListScreenState extends State<CamperListScreen> {
  late Database database;
  List<Camper> campers = [];

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  Future<void> _openDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'campers_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE campers(id INTEGER PRIMARY KEY, firstName TEXT, birthday DATETIME)',
        );
      },
      version: 1,
    );

    _loadData();
  }

  Future<void> _loadData() async {
    final List<Map<String, dynamic>> maps = await database.query('campers');
    setState(() {
      campers = List.generate(maps.length, (i) {
        return Camper(
          id: maps[i]['id'],
          firstName: maps[i]['firstName'],
          birthday: maps[i]['birthday'],
        );
      });
    });
  }

  Future<void> _insertData(Camper camper) async {
    await database.insert(
      'campers',
      camper.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _loadData();
  }

  Future<void> _updateData(Camper camper) async {
    await database.update(
      'campers',
      camper.toMap(),
      where: 'id = ?',
      whereArgs: [camper.id],
    );
    _loadData();
  }

  Future<void> _deleteData(int id) async {
    await database.delete(
      'campers',
      where: 'id = ?',
      whereArgs: [id],
    );
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camper List'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: campers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CamperDetailScreen(
                    camper: campers[index],
                    onUpdate: _updateData,
                    onDelete: _deleteData,
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('First Name: ${campers[index].firstName}'),
                  Text('Date of Birth: ${campers[index].birthday.toString()}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCamperScreen(
                onAdd: _insertData,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}