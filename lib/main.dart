import 'dart:convert';

import 'package:bhive/screens/About.dart';
import 'package:bhive/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var stringValue = _prefs.getString('user');
  if(stringValue != null){
    runApp(const MaterialApp(home: My(),));
  }else{
    runApp(const MaterialApp(home: Login(),));
  }
}

class My extends StatefulWidget {
  const My({ Key? key }) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  var _selectedIndex = 0;
  var arrayOfWindows = [const Home() , const About()];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: arrayOfWindows[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      )
    );
  }
}

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late String password, email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                validator: (value){
                  if (value!.isEmpty){
                    return "ENTER EMAIL";
                  }else{
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    if(!emailValid){
                      return "Enter Correct Email";
                    }
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'ameybhosle3@gmail.com',
                  labelText: 'Enter Email',
                  // border
                ),
                onSaved: (value)=> email=value!,
              ),
            ),
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "ENTER Password";
                }return null;
              },
              obscureText: true,
              decoration: const InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.black)
                ) 
              ),
              onSaved: (value)=> password = value!,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    var url = Uri.parse('http://localhost:1001/login');
                    var body = <String,String>{
                      'email':email,
                      'password':password
                    };
                    var response = await http.post(url,body:body);
                    if(response.statusCode == 200){
                      var data = jsonDecode(response.body);
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      _prefs.setString('user', data['token']);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const My()),);
                    }else{

                    }
                  }
                }, 
                child: const Text('Submit',style: TextStyle(color: Colors.white),),
                // ignore: prefer_const_constructors
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}