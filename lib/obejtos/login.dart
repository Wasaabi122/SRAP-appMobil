import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:srapv1/main.dart';
import 'package:srapv1/obejtos/pantalla.dart';
import 'package:srapv1/obejtos/regPan.dart';
class Login extends StatelessWidget {
 //declaracion de atributos
 static const String idPan = "inicio"; // nombre de la ruta
TextEditingController emailTextEditController = TextEditingController(); //crear una variable para guardar el texto de email
TextEditingController contraTextEditController = TextEditingController();//crear una variable para guardar el texto de contrasenia
  //metodos
  @override
  Widget build(BuildContext context) { //methodo para generar los graficos
    return Scaffold( //pintar los objetos graficos
      backgroundColor: Colors.white, //color de fondo blanco
      body: Column(// organiza en columnas
        children: [//crea en un solo grupo los textos
          SizedBox(height: 35.0,),
          Text( //genera el titulo inicio de sesion
            "Inicio de sesion:",
            style: TextStyle(fontSize: 24.0, fontFamily: "Mont"),
            textAlign: TextAlign.center,
          ),
          Padding( 
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [//genera el formulario de ingresos
                SizedBox(height: 1.0,),
          TextField(//genera el ingreso para el email
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
          TextField(//genera el ingreso para la contrasenia
            controller: contraTextEditController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Contraseña",
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
            //crea el boton "Iniciar sesion"
            SizedBox(height: 1.0,),
            RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text(
                    "Iniciar sesion",
                    style: TextStyle(fontSize: 18.0, fontFamily: "Mont"),
                  ),
                ),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(24.0),
              ),
              onPressed: (){//cuando es presionado hacer una mapeo para evitar errores de texto y si se ingresa uno hacer metodo displayToastMsg
                if(!emailTextEditController.text.contains("@") || !emailTextEditController.text.contains(".")){
                  displayToastMsg("Ingrese de nuevo el email", context);
                }else if(contraTextEditController.text.isEmpty){
                  displayToastMsg("Ingrese de nuevo la contraseña", context);
                }else{
                   loginUs(context); //ir a al metodo loginUs
                }
              },
            ),

              ],
            ),
          ),

          FlatButton( //crear boton con un texto
            onPressed:(){
              Navigator.pushNamedAndRemoveUntil(context, RegPan.idPan, (route) => false);// si se preciona que la pantalla cambie al formulario de registros
            } ,
            child: Text(
              "No tienes cuenta aun, registrate aqui", //texto
            ),
          )
        ],
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //variable para instancia de la base datos
  Future<void> loginUs(BuildContext context) async //metodo loginUs
  {/* PRUBA !!NO HACER CASO!!
   final user = (await _firebaseAuth
      .signInWithEmailAndPassword(
      email: emailTextEditController.text, 
      password: contraTextEditController.text
      ).catchError((errMsg){
        displayToastMsg("Error:" + errMsg.toString(), context);
      })).user;

      if(user != null) //inicio de sesion
      { 
       userRef.child(user.uid).once().then((DataSnapshot snap){
         if(snap.value != null){
           Navigator.pushNamedAndRemoveUntil(context, Pantalla.idPan, (route) => false);
           displayToastMsg("Se inicio sesion", context);
         }else{
           _firebaseAuth.signOut();
           displayToastMsg("El usuruario no exixte por favor crea una cuenta", context);
         }
       });
       
       
    }else{
      displayToastMsg("Error: No se pudo iniciar sesion", context); //error - no inicio
    }
    */

    try{//preguntar a la base datos si se encontro el email y la contrasenia y si estas son correctas
     final user = (await _firebaseAuth.signInWithEmailAndPassword(
       email: emailTextEditController.text, 
       password: contraTextEditController.text)).user;

       if(user != null) //ir a pantalla si no es nulo, es decir si eexiste
      { 
       userRef.child(user.uid).once().then((DataSnapshot snap){//guardar el ID de el usuario
         if(snap.value != null){//si el ID es distinto a nulo
           Navigator.pushNamedAndRemoveUntil(context, Pantalla.idPan, (route) => false); //ir a pantalla
           displayToastMsg("Se inicio sesion", context);// ir al metodo displayToastMsg
         }else{
           _firebaseAuth.signOut();//cerrar la instancia de la base datos
           displayToastMsg("El usuruario no exixte por favor crea una cuenta", context);
         }
       });
       
       
    }else{
      displayToastMsg("Error: No se pudo iniciar sesion", context); //error - no inicio
    }
    
    }on FirebaseAuthException catch(e){
      displayToastMsg("Error: " + e.toString(), context); //imprimir los errores de la autentificacion
    }
  }
    displayToastMsg(String mensaje, BuildContext context){
    Fluttertoast.showToast(msg: mensaje);// genera un pantalla emergente que imprime en pantalla los textos proporcionados
    
  }
}