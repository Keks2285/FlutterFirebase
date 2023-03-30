import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebaseService.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 3, 158, 162),
        body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  margin: EdgeInsets.fromLTRB(50, 30, 50, 10),
                  child: TextFormField(
                      validator: (value) {
                        if ((value ?? '').isEmpty)
                          return 'Пожалуйста введите свой Email';

                        String p =
                            r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$";
                        RegExp regExp = new RegExp(p);

                        if (regExp.hasMatch(value!)) return null;

                        return 'Неверный формат почты';
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Введите почту",
                      ))),
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Введите пароль")),
              ),
              //Text(state.message!),
              Container(
                  //color: Colors.black,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text("Зарегестрироваться"),
                    onPressed: () async {
                      firebaseService.onRegister(
                        email: emailController.text,
                        password: passController.text,
                      );

                      
                    },
                  )),
              //returnTextState(state)
              // Container(
              //  child:

              //)
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/SignIn");
            }));
  }

  // Widget returnTextState( AuthBlocState state){
  //   if(state is AuthFailedState){
  //     return Text(state.message);
  //   }
  //   return Text(state.message);
  // }
}
