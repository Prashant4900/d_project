import 'dart:convert';

import 'package:d_project/modals/itemModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ListOfItems with ChangeNotifier{

  static final ListOfItems _list = ListOfItems._internal();

  factory ListOfItems(){
    return _list;
  }

  ListOfItems._internal(){
    itemList = getItems();
  }

  Future<List<Item>> itemList;


  Future<List<Item>> getItems() async{
    List<Item> itemList1;
    var url = 'http://13.127.202.246/api/get_products';
    var response = await http.post(url, body: {
      "phone_no" : "7999867216",
    });
    var data = json.decode(response.body);
    print(data);
    if(data["error"] != "true"){
      var rest = data['item'] as List;
      itemList1 = rest.map<Item>((json) => Item.fromJson(json)).toList();
    }
  return itemList1;
  }
}