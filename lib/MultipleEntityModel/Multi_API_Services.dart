import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Multiple_Post_Model.dart';

class MultiApiServices {

  Future<List<MultiplePostWithModel>?> getMultiplePostModelWithModel() async{

    try{
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments");

      var multipleResponse = await http.get(url);

      if(multipleResponse.statusCode == 200 || multipleResponse == 201){

        List<MultiplePostWithModel> model = List<MultiplePostWithModel>.from(json.decode(multipleResponse.body).map((x) => MultiplePostWithModel.fromJson(x)));

        return model;

      }
    }
    catch(e){
      print(e.toString());
    }

    return null;
  }
}