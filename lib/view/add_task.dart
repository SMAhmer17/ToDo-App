

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/model/task_model.dart';
import 'package:todoapp/theme/theme.dart';
import 'package:todoapp/view/widgets/button.dart';
import 'package:todoapp/view/widgets/input_field.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

    // dependency inject
  final TaskController _taskController = Get.put(TaskController());

  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM ";
  String _startTime = DateFormat("hh:mm:a").format(DateTime.now()).toString();

  int _selectedRemind = 5;
  List<int> remindList = [
    5,10,15,20
  ];

    String _selectedRepeat = "None";
  List<String> repeatList = [
    "None" , "Daily" , "Weekly" , "Monthly" 
  ];

  // for selected color

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left :  20 , right: 20 , top: 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start
            ,
            children: [
              Text('Add Task' , style: headingStyle,),
              InputField(title: 'Title', hint: 'Enter your title' , controller: _titleController,),
              InputField(title: 'Note', hint: 'Enter note here' , controller: _noteController, ),
              InputField(title: 'Date', hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(onPressed: (){
                _getDateFromUser(context);

              }, icon: Icon(Icons.calendar_month , color: Colors.grey.shade600,)) ,
              ),
              Row(
                children: [
                  Expanded(
                    child:
                  InputField(title: "Start Time", hint: _startTime ,
                  widget: IconButton(onPressed: (){
                        _getTimeFromUser(isStartTime: true);
                  }, icon: Icon(Icons.access_time_rounded, color: Colors.grey.shade600,)),) ),
                   
                   const SizedBox(width: 12,),
                   
                   Expanded(
                    child:
                  InputField(title: "End Time", hint: _endTime ,
                  widget: IconButton(onPressed: (){ 
                     _getTimeFromUser(isStartTime: false);

                  }, icon: Icon(Icons.access_time_rounded , color: Colors.grey.shade600,)),) )
                ],
              ),
              InputField(title: "Remind", hint: "$_selectedRemind minutes early" ,
              
                  // DropDown
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down , 
                color: Colors.grey.shade600,),
                style: subTitleStyle,
                dropdownColor: Colors.amber,
                underline: Container(height: 0,),
                 iconSize: 32,
                items: remindList.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),);
                }).toList(),
                 onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                 }),
               ),
              

              InputField(title: "Repeat", hint: "$_selectedRepeat" ,
              
                  // DropDown
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down , 
                color: Colors.grey.shade600,),
                style: subTitleStyle,
                dropdownColor: Colors.amber,
                underline: Container(height: 0,),
                 iconSize: 32,
                items: repeatList.map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!),);
                }).toList(),
                 onChanged: (String? newValue){
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                 }),
               ),
               const SizedBox(height: 8,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _colorPallete(),
                   MyButton(label: "Create Task", onTap: (){

                    _validateData();
                   })
                 ],
                  )
                ],
               )
              
            
            
            
            
          ),
        ),

      
    );
  }

  _appBar(BuildContext context){
  return AppBar(
     leading: GestureDetector(    
      onTap: () {
        Get.back();
        },
      child: Icon(Icons.arrow_back_ios),  
    ),

    elevation: 0,
    backgroundColor: context.theme.appBarTheme.backgroundColor,
    actions: const [
     CircleAvatar(
      backgroundImage: AssetImage('images/men.jpeg'),
     ),
    SizedBox(width: 20,)
    ],
  
  );  
}


_getDateFromUser(BuildContext context) async{

  DateTime? _pickDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020) ,
     lastDate: DateTime(2025));

     if(_pickDate != null){
     setState(() {
        _selectedDate = _pickDate;

     });
     }else{
        print('It is null or something is wrong');
     }
}


_getTimeFromUser({required bool isStartTime}) async {
  var pickedTime = await  _showTimePicker();
  String _formatedTime = pickedTime.format(context);
  if(pickedTime == null){
    print('Time Canceled');
  }else if(isStartTime == true){
    setState(() {
      _startTime = _formatedTime;  
    });
    
  }else if(isStartTime == false){
    setState(() {
      _endTime  = _formatedTime;  
    });
    
  }

}

  _showTimePicker(){
    return showTimePicker(
      context: context,
    initialEntryMode: TimePickerEntryMode.input ,
     initialTime: TimeOfDay( 
      
      // startTime --> 10:30 am
      
       hour: int.parse(_startTime.split(":")[0]), 
      minute: int.parse(_startTime.split(":")[1].split(" ")[0])
      ));

  }

  _colorPallete(){
    return   Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text('Color' , style: titleStyle,),
                      const SizedBox(height: 8,),
                      Wrap( // wrap have dirction of axis as horizontal
                        children: List<Widget>.generate(
                            3, (int index){
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right : 8.0),
                                  child: CircleAvatar(radius: 12,  
                                  backgroundColor: index == 0 ?  primaryClr : index == 1 ?  pinkClr : Colors.amber ,
                                  child: _selectedColor == index ?  Icon(Icons.done , size: 15, color: Colors.white,) : Container(),
                                  
                                  ),
                                
                                ),
                              );
                              
                            })
                        ) ,],
                      );
                   
  }

_validateData(){
  if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
        // add to db
        _addTaskToDB();
    Get.back();
  }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
    Get.snackbar('Required', 'All fields are required !' ,
    snackPosition: SnackPosition.BOTTOM ,
    backgroundColor: Color.fromARGB(255, 174, 224, 255) ,
    icon: Icon(Icons.warning_amber_outlined));
    
  }
}

_addTaskToDB() async {

  int value = await _taskController.addTask(

   Task(
    title: _titleController.text,
    note: _noteController.text,
    date: DateFormat.yMd().format(_selectedDate),
    startTime: _startTime,
    endTime: _endTime,
    remind: _selectedRemind,
    repeat: _selectedRepeat,
    color: _selectedColor,
    isCompleted: 0
  )
  );
  print("Inserted id is ${value}");
}




}