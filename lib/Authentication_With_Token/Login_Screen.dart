import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Profile_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String baseUrl = "https://dummyjson.com";
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });
    try{
      final response = await http.post(
       Uri.parse("$baseUrl/auth/login"),
        body: jsonEncode({
          'username' : username.text,
          'password' : password.text
        }),
        headers: {
         'Content-type' : 'application/json'
        }
      );
      print(response.body);
      final data = jsonDecode(response.body);
      String token = data['accessToken'];
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(accessToken: token,)));
    }
    catch(e){
      print(e.toString());
    }
    finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          TextFormField(
            controller: username,
            decoration: InputDecoration(
              hintText: "UserName",
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          SizedBox(height: 30,),
          isLoading ? Center(child : CircularProgressIndicator()) :
          ElevatedButton(
              onPressed: login,
              child: Text("Login")
          ),
        ],
      ),
    );
  }
}
// testing