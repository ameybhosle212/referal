// ignore_for_file: file_names

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child:Text("Hello in About"),
        ),
      ) 
    );
  }
}