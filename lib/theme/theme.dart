
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


const Color bluishClr = Color(0xFF4e5ae8);
const Color yelloClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color whiteClr = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);


class Themes{

     // DEFAULT THEME - Light
      static final light =  ThemeData(
      
        primaryColor: whiteClr,
        brightness: Brightness.light,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: whiteClr
        )
      );

           // Dark Theme
      static final dark =  ThemeData(
          scaffoldBackgroundColor:Colors.black87,
         primaryColor: darkGreyClr,
        brightness: Brightness.dark,
        useMaterial3: true,
         appBarTheme: AppBarTheme(
          backgroundColor: Colors.black
        )
      );


}

TextStyle get subHeadingStyle{
  
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color : Get.isDarkMode ? Colors.grey[300] : Colors.grey 
    )
  );
}

TextStyle get headingStyle{
  
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color : Get.isDarkMode ? whiteClr : Colors.black 
    )
  );
}

TextStyle get titleStyle{
  
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color : Get.isDarkMode ? whiteClr : Colors.black 
    )
  );
}

TextStyle get subTitleStyle{
  
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color : Get.isDarkMode ? Colors.grey.shade300 :Colors.grey.shade700,
    )
  );
}