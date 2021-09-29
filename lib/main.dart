import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:srapv1/obejtos/login.dart';
import 'package:srapv1/obejtos/pantalla.dart';
import 'package:srapv1/obejtos/regPan.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Mont",
        primarySwatch: Colors.blue,
      ),
      initialRoute: Login.idPan,
      routes: {
        RegPan.idPan: (context) => RegPan(),
        Login.idPan: (context) => Login(),
        Pantalla.idPan: (context) => Pantalla(),
      }, 
      debugShowCheckedModeBanner: false,
    );
  }
}
