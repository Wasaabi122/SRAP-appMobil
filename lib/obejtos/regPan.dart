import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:srapv1/main.dart';
import 'package:srapv1/obejtos/login.dart';
import 'package:srapv1/obejtos/pantalla.dart';
class RegPan extends StatelessWidget {

static const String idPan = "registro";
TextEditingController nomTextEditController = TextEditingController();
TextEditingController apellidoPTextEditController = TextEditingController();
TextEditingController apellidoMTextEditController = TextEditingController();
TextEditingController emailTextEditController = TextEditingController();
TextEditingController contraTextEditController = TextEditingController();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 35.0,),
          Text(
            "Registrar nuevo usuario:",
            style: TextStyle(fontSize: 24.0, fontFamily: "Mont"),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [

          SizedBox(height: 1.0,),
            TextField(
              controller: nomTextEditController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nombre",
              labelStyle: TextStyle(
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 10.0,
              ),
            ),
            style: TextStyle(
              fontSize: 14.0
            ),
          ),

          SizedBox(height: 1.0,),
            TextField(
            controller: apellidoPTextEditController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Apellido paterno",
              labelStyle: TextStyle(
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 10.0,
              ),
            ),
            style: TextStyle(
              fontSize: 14.0
            ),
          ),
          
                    SizedBox(height: 1.0,),
            TextField(
            controller: apellidoMTextEditController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Apellido Materno",
              labelStyle: TextStyle(
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 10.0,
              ),
            ),
            style: TextStyle(
              fontSize: 14.0
            ),
          ),

          SizedBox(height: 1.0,),
          TextField(
            controller: emailTextEditController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 10.0,
              ),
            ),
            style: TextStyle(
              fontSize: 14.0
            ),
          ),

          SizedBox(height: 1.0,),
          TextField(
            controller: contraTextEditController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 10.0,
              ),
            ),
            style: TextStyle(
              fontSize: 14.0
            ),
          ),

            SizedBox(height: 1.0,),
            RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text(
                    "Registrar",
                    style: TextStyle(fontSize: 18.0, fontFamily: "Mont"),
                  ),
                ),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(24.0),
              ),
              onPressed: (){
                if(nomTextEditController.text.length < 3){
                   displayToastMsg("Ingrese de nuevo el nombre", context);

                }else if(apellidoPTextEditController.text.length < 3){
                  displayToastMsg("Ingrese de nuevo el apellido paterno", context);
                }else if(apellidoMTextEditController.text.length < 3){
                  displayToastMsg("Ingrese de nuevo el apellido materno", context);
                }else if(!emailTextEditController.text.contains("@") || !emailTextEditController.text.contains(".")){
                  displayToastMsg("Ingrese de nuevo el email", context);
                }else if(contraTextEditController.text.length < 8){
                  displayToastMsg("Ingrese de nuevo la contraseña con 8 o mas caracteres", context);
                }else{
               registerNewUser(context);
                }
              },
            ),

              ],
            ),
          ),

          FlatButton(
            onPressed:(){
              Navigator.pushNamedAndRemoveUntil(context, Login.idPan, (route) => false);
            } ,
            child: Text(
              "ya tienes cuenta, inicia sesion aqui",
            ),
          )
        ],
      ),
    );
  }

  void registerNewUser(BuildContext context) async {
    final user = (await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailTextEditController.text, 
      password: contraTextEditController.text).catchError((errMsg){
        displayToastMsg("Error:" + errMsg.toString(), context);
      })).user;
    if(user != null){ //crea usuraio
      //guarda en la app
       
       Map userDataMap = {
         "nombre": nomTextEditController.text.trim(),
         "ApellidoP": apellidoPTextEditController.text.trim(),
         "ApellidoM": apellidoMTextEditController.text.trim(),
         "Email": emailTextEditController.text.trim(),
       };

       userRef.child(user.uid).set(userDataMap);
       displayToastMsg("Nuevo usuraio creado", context);
       Navigator.pushNamedAndRemoveUntil(context, Pantalla.idPan, (route) => false);
    }else{
      displayToastMsg("Error: Usurio no se pudo guardar correctamente", context); //error - vuelve a ingresar los datos
    }
  }
  displayToastMsg(String mensaje, BuildContext context){
    Fluttertoast.showToast(msg: mensaje);
  }
}