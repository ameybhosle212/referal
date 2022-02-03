// ignore_for_file: file_names

import 'package:bhive/screens/ReferalSection.dart';
import 'package:bhive/screens/Referaldashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Referal extends StatefulWidget {
  const Referal({ Key? key }) : super(key: key);

  @override
  _ReferalState createState() => _ReferalState();
}

class _ReferalState extends State<Referal> {
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
          children:  [
            const Padding(
              padding: EdgeInsets.fromLTRB(120,20,0,20),
              child: Text('Referral Section',
                style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.fromLTRB(20,10,0,0),
              child:  Text("Why don't You Introduce With Your Friends?",
              style:TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold, 
                ),
              ),
            ),
            const SizedBox(
              height:90
            ),
            Container(
              width:250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ReferalSection()),);
                }, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.black)
                    ),
                  ),
                ),
                child: const Text('Refer a Friend',
                style:TextStyle(
                      color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold, 
                  ),
                )
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width:250,
              height: 50,
              decoration: const BoxDecoration(
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.black)
                    ),
                  ),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ReferalDashboard()),);
                }, 
                child: const Text('Referral Dashboard',
                    style:TextStyle(
                      color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold, 
                  ),
                )
              ),
            ),
          ],
        ),
      ) 
    );
  }
}