import 'package:flutter/material.dart';

import 'API_services.dart';
import 'Single_Post_Model.dart';

class ScreenWithModel extends StatefulWidget {
  const ScreenWithModel({super.key});

  @override
  State<ScreenWithModel> createState() => _ScreenWithModelState();
}

class _ScreenWithModelState extends State<ScreenWithModel> {

  bool isReady = false;

  SinglePostWithModel singlePostWithModel = SinglePostWithModel();

  _getSinglePost(){
    isReady = true;
    ApiServices().getSinglePostWithModel().then((value){
      setState(() {
          singlePostWithModel = value!;
          isReady = false;
      });
    }).onError((error, stackTrace){
      print(error);
      setState(() {
        isReady = false;
      });
    });
  }

  @override
  void initState(){
    _getSinglePost();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Screen With Model"),
        backgroundColor: Colors.blue,
      ),

      body: isReady == true ?
          Center(child: CircularProgressIndicator(),) :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(singlePostWithModel.userId.toString(), style: TextStyle(fontSize: 20, color: Colors.blue),),
              Text(singlePostWithModel.title.toString(), style: TextStyle(fontSize: 20, color: Colors.blue),),
              Text(singlePostWithModel.body.toString(), style: TextStyle(fontSize: 20, color: Colors.blue),),
            ],
          )
    );
  }
}
