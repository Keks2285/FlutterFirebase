import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:firebaseauth/firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
QuerySnapshot? querySnapshot;
final User? user = FirebaseAuth.instance.currentUser;
//SharedPreferences? sharedPreferences;
List<Map<String, dynamic>> userList = [];
CollectionReference usersImage =
    FirebaseFirestore.instance.collection('images');







class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key, required this.title});

  final String title;

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
      GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController _nameController = new TextEditingController();
  int _counter = 0;

  void _incrementCounter() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: 'Выбор файла',
    );
    if (result != null) {
      final size = result.files.first.size;
      final file = io.File(result.files.single.path!);
      final fileExtensions = result.files.first.extension!;
      print("размер:$size file:${file.path} fileExtensions:${fileExtensions}");
      String names = getRandomString(5);
      await FirebaseStorage.instance.ref().child(names).putFile(file);

      final urlFile =
          await FirebaseStorage.instance.ref().child(names).getDownloadURL();
      // print("CCSKFJDFFDJFJHDDFJJFFJHFDFDJFJDFDJFJDJFDJ    :$urlFile");
      final imagesAdd = fireStore.collection('images');
      imagesAdd
          .add(
            {
              'name': names,
              'nameFile': names,
              'size': result.files.first.size,
              'url': urlFile,
              'user': user!.email
            },
          )
          .then((value) => print('Add image'))
          .catchError((error) => print('Faild add: $error'));
    } else {}
    initImage();
  }

  Future<void> DeleteImage() async {
    //sharedPreferences = await SharedPreferences.getInstance();
    await FirebaseStorage.instance.ref("/" + fullname).delete();
    if (link != '') {
      querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('url', isEqualTo: link)
          .get();
      fullpath.clear();

      querySnapshot?.docs.forEach((doc) async {
        await usersImage.doc(doc.id).delete();
      });
    }
    initImage();
  }

  String link = '';
  String fullname = '';
  List<ModelTest> fullpath = [];

  

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> initImage() async {
    //sharedPreferences = await SharedPreferences.getInstance();
    querySnapshot = await FirebaseFirestore.instance
        .collection('images')
        .where('user', isEqualTo: user!.email)
        .get();
    fullpath.clear();

    final storageReference = querySnapshot!.docs.toList();
    // final storageReference = FirebaseStorage.instance.ref().list();
    final list = await storageReference;
    list.forEach((element) async {
      final url = await element.get('url');
      final name = await element.get('nameFile');
      final nameFile = await element.get('name');
      final size = await element.get('size');
      fullpath.add(ModelTest(url, name, size, nameFile));
      setState(() {
        link = '';
        _nameController.text = '';
      });
    });
  }

  @override
  void initState() {
    initImage().then(
      (value) {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.green,
          title: Text(
            'Мои фото',
            style: TextStyle(color: Colors.white),
          ),
        actions: [
          
        ],
            centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: fullpath.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onLongPress: () async {
                        link = fullpath[index].url;
                        fullname = fullpath[index].nameFile;
                        await DeleteImage();
                      },
                      onTap: () {
                        setState(() {
                          link = fullpath[index].url;
                          _nameController.text = fullpath[index].name;
                        });
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Image.network(
                            fullpath[index].url,
                            errorBuilder: (context, error, stackTrace) {
                              return Text('');
                            },
                          ),
                        ),
                        title: Text("Название: " + fullpath[index].name),
                        subtitle: Text("Размер: " +
                            fullpath[index].size.toString() +
                            " Ссылка: " +
                            fullpath[index].url),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Название файла',
                        ),
                      ),
                    ),
                    Image.network(
                      link,
                      width: 150,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Картинка не выбрана');
                      },
                    ),
                  ],
                ))
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ModelTest {
  final String url;
  final String name;
  final String nameFile;
  final int size;

  ModelTest(this.url, this.name, this.size, this.nameFile);
}