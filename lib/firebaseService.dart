import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  factory FirebaseService() => _singleton;

  FirebaseService._internal();

  final auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  bool succesLogin = false;
  onListenUser(void Function(User?)? doListen) {
    auth.authStateChanges().listen(doListen);
  }

  onAnonimLogin() async {
    try {
      final userCredential = await auth.signInAnonymously();
      print("Signed in with temporary account.");
      succesLogin = true;
    } on FirebaseAuthException catch (e) {
      succesLogin = false;
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  onLogin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(credential);
      succesLogin = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        succesLogin = false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        succesLogin = false;
      }
    }
  }

  onRegister({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }


    ///fireStoreadd
    final userAdd = fireStore.collection('users');
    userAdd
        .add(
          {
            'email': email,
            'password': password,
          },
        )
        .then((value) => print('Add user'))
        .catchError((error) => print('Faild add: $error'));
  }

  logOut() async {
    await auth.signOut();
  }

  onVerifyEmail() async {
    await currentUser?.sendEmailVerification();
  }
}
