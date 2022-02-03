// ignore_for_file: file_names
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:bhive/screens/Referal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);
   gettta()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    return decodedToken;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer:  Drawer(
          child:ListView(
            children: [
              DrawerHeader(
                child: Stack(
                  children: const [
                    Text('HELLO')
                  ],
                ),
              ),
              ListTile(
                title: const Text('Referal Section'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Referal()),);
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: ()async{
                  SharedPreferences _prefs = await SharedPreferences.getInstance();
                  _prefs.remove('user');
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: const Text("Hello in Home"),
      ) 
    );
  }
}
