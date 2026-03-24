import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {

  final String accessToken ;
  const ProfileScreen({super.key, required this.accessToken});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  bool isLoading = false;
  String result = '';

  void getProfile () async {
    setState(() {
      isLoading = true;
    });
    try{
      final response = await http.get(
          Uri.parse('https://dummyjson.com/auth/me'),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}', // Pass JWT via Authorization header
        },
      );

      result = response.body;
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
        title: Text("Profile Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator() : Text(result),
      ),
    );
  }
}
