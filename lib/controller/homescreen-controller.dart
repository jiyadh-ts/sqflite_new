import 'package:sqflite/sqflite.dart';

class HomescreenController {
  static List myDataList = [];
  static late Database database;
  static Future<void> initDb() async {
    database = await openDatabase("mydb.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employee (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

  static Future<void> addEmployee(
      {required String name, required String designation}) async {
    await database.rawInsert(
        'INSERT INTO Employee(name, designation) VALUES(?, ?)',
        [name, designation]);
  }

  static Future<void> deleteEmployee({required var id}) async {
    await database.rawDelete('DELETE FROM Employee WHERE id = ?', ['$id']);
  }

  Future<void> getEmployee() async {
    List<Map> list = await database.rawQuery('SELECT * FROM Employee');
    print(list);
    myDataList = list;
  }

  void updateEmployee() {}
}
