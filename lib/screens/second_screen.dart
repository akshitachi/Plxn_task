// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plxn_task/database.dart';
import 'package:plxn_task/screens/profile_page.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Plxn App'),
      ),
      body: FutureBuilder(
        future: DataBaseService().getUserdetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List userData = [];
            Map userDataMap = (snapshot.data) as Map;
            userDataMap.forEach((key, value) {
              userData.add(value);
            });
            print(userData);
            return ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userData[index]['email']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            userData: userData[index],
                          ),
                        ),
                      );
                    },
                  );
                });
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
