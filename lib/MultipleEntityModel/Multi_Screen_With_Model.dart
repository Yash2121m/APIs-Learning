import 'package:flutter/material.dart';

import 'Multi_API_Services.dart';
import 'Multiple_Post_Model.dart';

class MultiScreenWithModel extends StatefulWidget {
  const MultiScreenWithModel({super.key});

  @override
  State<MultiScreenWithModel> createState() => _MultiScreenWithModelState();
}

class _MultiScreenWithModelState extends State<MultiScreenWithModel> {

  bool isReady = false;

  List<MultiplePostWithModel> multiplePostModel = [];
  _getMultiplePost(){
    isReady = true;
    MultiApiServices().getMultiplePostModelWithModel().then((value){
      setState(() {
          multiplePostModel = value!;
          isReady = false;
          print(value);
      });
    });
  }

  @override
  void initState() {
    _getMultiplePost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Multiple Entity Get API"),
        backgroundColor: Colors.blue,
      ),

      body: isReady == true ?
      const Center(child: CircularProgressIndicator()):
          ListView.builder(
              itemCount: multiplePostModel.length,
              itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: Text(multiplePostModel[index].id.toString(), style: TextStyle(color: Colors.blue, fontSize: 20),),
                      title: Text(multiplePostModel[index].name.toString(), style: TextStyle(color: Colors.blue, fontSize: 20),),
                      subtitle: Text(multiplePostModel[index].email.toString(), style: TextStyle(color: Colors.blue, fontSize: 20),),
                    ),
                  );
          })
    );
  }
}
