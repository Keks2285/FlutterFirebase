import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//final FirebaseFirestore fireStore = FirebaseFirestore.instance;
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _oldPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  Future<void> refreshProfile() async {
    //Query
    String uId="";
    final users= await FirebaseFirestore.instance.collection('users');
    users.where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then(
      (QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc)async{
        print(doc.id);
          final User? user = FirebaseAuth.instance.currentUser;
          await user?.updatePassword(_newPasswordController.text);
          await user?.updateEmail(_emailController.text);

          await FirebaseFirestore.instance.collection('users').doc(doc.id).update({
              'email':_emailController.text,
              'password':_newPasswordController
            }).catchError((onError)=>print(onError));
      });
    });
    //
    //var u =userQ.firestore;
    //var u = userQ.where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
      //getDocs()
    // userQ.get().then((DocumentReference documentSnapshot) {
      
    // });
    //print(FirebaseAuth.instance.currentUser!.email);
    //return 
    // userInDb.get().then(
    //   (value) {
    //     value.forEach(value)
    //   });
    //    final User? user = FirebaseAuth.instance.currentUser;
    //    await user?.updatePassword(_newPasswordController.text);
    // return user
    // .where('email', isEqualTo: _emailController.text);
    // var s =querySnapshot?.docs.first.get('password');
    // if (querySnapshot?.docs.first.get('password') ==
    //     _oldPasswordController.text) {
    //   querySnapshot?.docs.forEach((doc) {
    //     users.doc(doc.id).update({'password': _newPasswordController.text});
    //   });
    //   final User? user = FirebaseAuth.instance.currentUser;
    //   await user?.updatePassword(_newPasswordController.text);
    // } else {
    //   const snackBar = SnackBar(
    //     content: Text('Неверный пароль'),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.green,
          title: Text(
            'Мой профиль',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/SignIn",arguments: false);
              },
            ),
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Мой email',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    obscureText: true,
                    controller: _oldPasswordController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Введите старый пароль',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    obscureText: true,
                    controller: _newPasswordController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Введите новый пароль',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        refreshProfile();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          )),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Изменить профиль",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ]),
                    ),
                  ),
                ),
              ],
            )),
          ],
    )));
  }
}
