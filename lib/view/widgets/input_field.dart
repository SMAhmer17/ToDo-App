
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/theme/theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputField({super.key, 
  required this.title, 
  required this.hint, 
  this.controller, 
  this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top : 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title , style: titleStyle ,),
        Container(
          margin: EdgeInsets.only(top: 8),
          height: 52,
          padding: EdgeInsets.only(left: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1
            ),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Expanded(child:
               TextFormField(
                 readOnly: widget == null ? false : true ,
                autofocus: false,
                cursorColor: Get.isDarkMode ? Colors.grey.shade100 :Colors.grey.shade700,
                controller: controller,
                style: subTitleStyle,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: subTitleStyle,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: context.theme.scaffoldBackgroundColor,
                      width: 0 
                    )
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: context.theme.scaffoldBackgroundColor,
                      width: 0 
                    )
                  )
                ),
              )),

              // to show suffix ixon bcz expanded take all the available sapace
               widget == null ?  Container() : Container(child: widget,)
          ]
          ,) ,
        )
        
        
        ],
      ),
    );
  }
}