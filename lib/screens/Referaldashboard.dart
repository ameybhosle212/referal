// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReferalDashboard extends StatefulWidget {
  const ReferalDashboard({ Key? key }) : super(key: key);

  @override
  _ReferalDashboardState createState() => _ReferalDashboardState();
}

class _ReferalDashboardState extends State<ReferalDashboard> {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  var cashEarned;
  @override
  void initState() {
    super.initState();
    getData();
  }
  void getData()async{
    var url = Uri.parse('http://localhost:1001/profile');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(url,body: {'token':prefs.get('user')});
    if(response.statusCode == 200) {
      setState(() {
        var last = jsonDecode(response.body);
        data = last['data'];
      });
    }
  }
  Widget getAllWidgets(){
    List<Widget> p = [];
    int sum = 0  ;
    for (var i = 0; i < data['referals'].length; i++) {
      // sum = sum + int.parse(data['referals']['reward']);
      // print(data['referals']['reward']);
      p.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(data['referals'][i]['name']),
            Text(data['referals'][i]['reward']),
            Text(data['referals'][i]['investment']),
          ],
        )
      );
    }
    // setState(() {
    //   cashEarned = sum;
    // });
    return Column(
      children: p,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text('Name'),
                Text('Reward Money'),
                Text('Invetment Status'),
              ],
            ),
            data == null ? const Center(child: CircularProgressIndicator(),) : getAllWidgets(),
            // ...getAllWidgets(),
            const SizedBox(
              height: 30,
            ),
            const Text('Cash Earned is'),
            const SizedBox(
              height: 30,
            ),
            // Text('$cashEarned'),
          ],
        ),
      )
    );
  }
}