
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/task_model.dart';

class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "Tasks";

  static Future<void> initDb()async{
    if(_db != null){
      return; 
    }
    try {

        // db created
      String _path = await getDatabasesPath() + "task.db";
      _db = await openDatabase(
         _path,
         version: _version,
         onCreate: (db, version) {
           print("Creating a new db");
              // teable created in db
           return db.execute(
            "CREATE TABLE  $_tableName ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT , "
            "title STRING , note TEXT , date STRING,"
            "startTime STRING , endTime STRING, "
            "remind INTEGER , repeat STRING ,"
            "color INTEGER , isCompleted INTEGER)"

           );
         },
      );
    }catch(e){
      print(e);
    }
  }



      // Insert
  static Future<int> insert(Task? task) async{
    
    print('insert function called');
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }


        // get all the data from table
    static Future<List<Map<String , dynamic>>> query() async{
    print('insert function called');
    return await _db!.query(_tableName) ;
  }


  static delete(Task task)async{
    await _db!.delete(_tableName , where: 'id=?' , whereArgs: [task.id]);
  }

  // update method

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE Tasks
      SET isCompleted = ?
      WHERE id =?
''' , [ 1,id]);
  }

}