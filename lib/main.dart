import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/theme/theme_services.dart';

import 'package:todoapp/view/home_screen.dart';
import 'package:todoapp/theme/theme.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
     
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme ,

     
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
