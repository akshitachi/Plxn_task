// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:plxn_task/database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    required this.userData,
    Key? key,
  }) : super(key: key);
  final userData;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var gender = (widget.userData as Map)['Gender'];
    var email = widget.userData['email'];
    var gstNo = (widget.userData)['gstNo'];
    var imageUrl = (widget.userData)['image_url'];
    var phoneNo = widget.userData['phoneNo'];
    var age = widget.userData['age'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          email,
          style: TextStyle(
              fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, right: 20, left: 20),
        child: Column(
          children: [
            Row(
              children: [
                imageUrl == null || imageUrl == ''
                    ? CircleAvatar(
                        backgroundColor: Colors.grey,
                        maxRadius: MediaQuery.of(context).size.width * 0.12,
                      )
                    : CircleAvatar(
                        maxRadius: MediaQuery.of(context).size.width * 0.12,
                        backgroundImage: NetworkImage(
                          imageUrl,
                        ),
                      ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone No.  -   ' + phoneNo,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        'GST No.-' + gstNo,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Age:' + age,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Gender  - ' + gender,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
