import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/model/task_model.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask(Task? task) async{
    return await DBHelper.insert(task);
   }

   void getTasks() async{
    List<Map<String , dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)));
   }

    void delete(Task task){

      DBHelper.delete(task);
      // refresh new screen
        getTasks();
      //  var val = DBHelper.delete(task);
      // print(val);
    }

    void markTaskCompleted(int id) async{
      await  DBHelper.update(id);
      // refresh new screen
        getTasks();
      
    }
}