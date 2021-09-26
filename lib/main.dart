import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/create_update_empdata.dart';
import 'package:flutter_app/view/emp_list.dart';

/**Employee demo with Firestore By Ashvinee Sasamkar**/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFF28406b),
          elevation: 5,
          shadowColor: Colors.black,
        ),
        scaffoldBackgroundColor: Color(0xFF20314e),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white, fontSize: 12),
          headline3: TextStyle(color: Color(0xFFf4de4c), fontSize: 15),
          button: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      initialRoute: EmpList.id,
      routes: {
        EmpList.id: (context) => EmpList(),
        CreateUpdateEmpData.id: (context) => CreateUpdateEmpData(),
      },
    );
  }
}
