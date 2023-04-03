import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';

import '../firebaseService.dart';

class SignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String message="";
  late var prefs;
  bool rememberMe=false;
  final FirebaseService firebaseService = FirebaseService();
  
  //SignInPage(String s);
  @override
  Widget build(BuildContext context) {
    



    //String a =""; 
    return   Scaffold(
                    backgroundColor: Color.fromARGB(255, 3, 158, 162),
                    
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin:  EdgeInsets.fromLTRB(0, 100, 00, 50),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(50, 10, 50, 50),
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Введите почту",
                                      ))),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(50, 0, 50, 50),
                                    child: TextFormField(
                                      controller: passController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Введите пароль")),
                                  ),
                                  //Text(message==""? state.message : message),
                                  Container(
                                    //color: Colors.black,
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 100,
                                          child: Text("Войти")
                                          ),
                                        onPressed: () async {
                                          await firebaseService.onLogin(
                                            email: emailController.text,
                                               password: passController.text,
                                            );
                                          if(firebaseService.succesLogin)
                                          //     email: emailController.text,
                                          //     password: passController.text,
                                          //     ))
                                           {
                                            firebaseService.succesLogin=false;
                                               Navigator.pushNamed(context,"/ImagesPage");
                                           }
                                          
                                            
                                           
                                        },
                                      )),

                                      Container(
                                    //color: Colors.black,
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 120,
                                          child: Text("Войти анонимно")
                                          ),
                                        onPressed: () async {
                                          await firebaseService.onAnonimLogin(
                                            );
                                          if(firebaseService.succesLogin)
                                          //     email: emailController.text,
                                          //     password: passController.text,
                                          //     ))
                                           {
                                            firebaseService.succesLogin=false;
                                               Navigator.pushNamed(context,"/ImagesPage");
                                           }
                                          
                                            
                                           
                                        },
                                      )),


                                      Container(
                                    //color: Colors.black,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 150,
                                          child: Text("Войти через google")
                                          ),
                                        onPressed: () async {
                                          
                                        },
                                      ))
                                      




                                      //returnTextState(state)
                                     // Container(
                                      //  child:
                          
                          
                                        
                                      //)
                                      
                                ]),
                                
                          ),
                          
                        Align(
                          
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                                        child: 
                                        ElevatedButton(
                                          child: Text("Регистрация"),
                                          
                                          onPressed: () {
                                          Navigator.pushNamed(context,"/SignUp");
                                          //prefsInit();
                                          }

                                        ),
                                      ),
                          
                          )
                              
                            
                        ],
                      ),

                      
                    );
  }



  // Widget returnTextState( AuthBlocState state){
  //   if(state is AuthFailedState){
  //     return Text(state.message);
  //   }
  //   return Text(state.message);
  // }



}
