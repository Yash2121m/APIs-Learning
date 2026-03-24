import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Single_Post_Model.dart';

class ApiServices {

  // With Model
  Future<SinglePostWithModel?> getSinglePostWithModel() async{
    try{
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");

      var response = await http.get(url);

      if(response.statusCode == 200 || response.statusCode == 201){

        SinglePostWithModel model = SinglePostWithModel.fromJson(json.decode(response.body));

        return model;
      }
    }
    catch(e){
      print(e.toString());
    }
    return null;
}
}