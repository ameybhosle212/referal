// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferalSection extends StatefulWidget {
  const ReferalSection({ Key? key }) : super(key: key);

  @override
  _ReferalSectionState createState() => _ReferalSectionState();
}

class _ReferalSectionState extends State<ReferalSection> {
  String name = '';
  @override
  void initState() {
    super.initState();
    gettta();
  }
  void gettta()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    setState(() {
      name = decodedToken['uname'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20,0,0,0),
              child: Text('Referral Section',
              style:TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold, 
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,0,0),
              child: Text('Hey $name',
              style:const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold, 
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}