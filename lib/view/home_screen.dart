import 'dart:math';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/model/task_model.dart';
import 'package:todoapp/services/notification_services.dart';
import 'package:todoapp/theme/theme.dart';

import 'package:todoapp/theme/theme_services.dart';
import 'package:todoapp/view/add_task.dart';
import 'package:todoapp/view/widgets/button.dart';
import 'package:todoapp/view/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

DateTime _selectedDate = DateTime.now();

   final TaskController _taskController = Get.put(TaskController());


  final  Notifyhelper = NotifyHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Notifyhelper.initializeNotification();
    
  }
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          
          _addDateBar(),

          const SizedBox(height: 12,),

          _showTasks(),
       
         
      

        ],
      ),
    );
  }

_addDateBar(){
  return 
          Container(
            margin: EdgeInsets.only(top: 20 , left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: whiteClr,
              
              dateTextStyle: GoogleFonts.lato(
                textStyle :  TextStyle(
                fontSize: 20,
                color:Get.isDarkMode ? Colors.white :  Colors.black54,
                fontWeight: FontWeight.w600),
              ),
              dayTextStyle:  GoogleFonts.lato(
                textStyle : TextStyle(
                fontSize: 14,
                color: Get.isDarkMode ? Colors.white :  Colors.black54,
                fontWeight: FontWeight.w600),
              ),
              
              

              monthTextStyle: GoogleFonts.lato(
                textStyle : TextStyle(
                fontSize: 14,
                color: Get.isDarkMode ? Colors.white :  Colors.black54,
                fontWeight: FontWeight.w600),
              ),
              onDateChange: (date){
                setState(() {
                   _selectedDate = date;
   
                });
                             },



             
            ),
          );
       
}

_addTaskBar(){

  return    Container(
             margin: const EdgeInsets.only(left : 20 , right : 20 , top : 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()) ,
                       style: subHeadingStyle ,),
                      Text('Today'  , style: headingStyle,)
                    ],
                  ),
                ),
              MyButton(label: '+ Add Task', onTap: () async {
               await Get.to(AddTaskPage());
                
                _taskController.getTasks();
                
                })
            
            ],),
          );


}

_appBar(){
  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.appBarTheme.backgroundColor,
    leading: GestureDetector(
      onTap: () {
        ThemeServices().switchTheme();
        Notifyhelper.displayNotification(
          title : 'Notification Theme Changed' ,
          body : Get.isDarkMode?'Activated Light Theme'  : 'Activated Dark Theme' 
        );
      },
      child: Get.isDarkMode ?  Icon(Icons.light_mode_rounded) : Icon(Icons.nightlight_round , 
      size: 20,),
    ),
    actions: const [
     CircleAvatar(
      backgroundImage: AssetImage('images/men.jpeg'),
     ),
    SizedBox(width: 20,)
    ],
  
  );  
}


_showTasks(){
  return Expanded(
    child:
     Obx(() {  return
      ListView.builder(
        itemCount: _taskController.taskList.length,
        itemBuilder: (context , index){
          print( _taskController.taskList.length);
          Task task = _taskController.taskList[index];

          if(task.repeat == "Daily"){
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        _showBottomSheet(context ,  task);
                      },
                      child: TaskTile( task),
                    )
                  ],
                   )
                 )
                )
              );
          }

          // By comparing date refresh screen and show specific date tasks return date in y/m/d format
          else if(task.date == DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        _showBottomSheet(context ,  task);
                      },
                      child: TaskTile( task),
                    )
                  ],
                   )
                 )
                )
              );
         
          }else{
            return Container();
          }
        } );
    }));
}

 _bottomSheetButon({
  required String label ,
  required Function()? onTap , 
  required Color clr ,
  required BuildContext context,
  bool isClosed = false}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width* .9,

        decoration: BoxDecoration(
          color: isClosed == true ?  Colors.transparent : clr,
          border: Border.all(
            width: 2,
            color: isClosed == true ? Get.isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300 : clr
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(label, 
        style: isClosed ? titleStyle :titleStyle.copyWith(color: Colors.white) ,
        )),
      
      )  
        );

 }

_showBottomSheet(BuildContext context , Task task){
  Get.bottomSheet(
    Container(
        padding: EdgeInsets.only(top: 4),
        height:  task.isCompleted == 1 ?
        
        MediaQuery.of(context).size.height * .24  :
        MediaQuery.of(context).size.height * .32  ,
        width: MediaQuery.of(context).size.width * 1,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [


            Container(height: 6,
            width: 120,
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Get.isDarkMode ? Colors.grey.shade600 :Colors.grey.shade300,
                
            ),),
          Spacer(),
            task.isCompleted==1 ? Container() 
            : 
            _bottomSheetButon(
              clr: primaryClr,
              label: "Task Completed",
              context: context,
              onTap: (){
                _taskController.markTaskCompleted(task.id!);
                Get.back();
                },
               ),

                const SizedBox(height:5,),
               // delete button

                    _bottomSheetButon(
              clr: Colors.red.shade700,
              label: "Delete Task",
              context: context,
              onTap: (){
                _taskController.delete(task);
       
                Get.back();},
               ),

                const SizedBox(height: 20,),
              //  3rd button

                    _bottomSheetButon(
              clr: Colors.red.shade700,
              label: "Close",
              context: context,
              isClosed: true,
              onTap: (){Get.back();},
               ),
                     const SizedBox(height: 10,),
          ],
        ),
    )
  );
}
}

