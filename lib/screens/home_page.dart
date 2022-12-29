// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plxn_task/screens/second_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  var age;
  String gender = 'Male';
  var userEmail;
  var phoneNo;
  var gstNo;
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }
    if (isValid) {
      Reference ref = FirebaseStorage.instance.ref().child(phoneNo);
      await ref.putFile(image!);

      final url = await ref.getDownloadURL();
      await FirebaseDatabase.instanceFor(
              app: Firebase.app(),
              databaseURL:
                  "https://plxntask-5de63-default-rtdb.firebaseio.com/")
          .ref()
          .child('Users')
          .child(phoneNo)
          .set({
        'email': userEmail,
        'phoneNo': phoneNo,
        'age': age,
        'gstNo': gstNo,
        'Gender': gender,
        'image_url': url
      });
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Plxn App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: image != null ? FileImage(image!) : null,
                  minRadius: MediaQuery.of(context).size.width * 0.2,
                  maxRadius: MediaQuery.of(context).size.width * 0.2,
                ),
                ElevatedButton.icon(
                  onPressed: pickImage,
                  label: Text('Add Image'),
                  icon: Icon(Icons.image),
                ),
                TextFormField(
                  maxLength: 3,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Please enter your age',
                  ),
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Text(
                      "Select your gender",
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    DropdownButton<String>(
                      value: gender,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 16,
                      style: const TextStyle(color: Colors.red),
                      underline: Container(
                        height: 2,
                        color: Colors.red,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female', 'Others']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                  onChanged: (value) {
                    setState(() {
                      userEmail = value;
                    });
                  },
                ),
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Please enter your phone no.',
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneNo = value;
                    });
                  },
                ),
                TextFormField(
                  maxLength: 15,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your gst no';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Please enter your gst no.',
                  ),
                  onChanged: (value) {
                    setState(() {
                      gstNo = value;
                    });
                  },
                ),
                OutlinedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    await trySubmit();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
