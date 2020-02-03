import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http_request2/data_model.dart';
import 'package:http/http.dart'as http;

class DataProvider extends ChangeNotifier{
  List<DataModel> _data =[];

  List<DataModel> get dataModel => _data;

  Future<List<DataModel>>getData() async {
    final url = 'https://api.banghasan.com/quran/format/json/surat';
    final response = await http.get(url);

    if(response.statusCode == 200){
      final result = json.decode(response.body)['hasil'].cast<Map<String, dynamic>>();

      _data = result.map<DataModel>((json)=> DataModel.fromJson(json)).toList();

      return _data;
    }else{
      throw Exception();
    }
  }

}