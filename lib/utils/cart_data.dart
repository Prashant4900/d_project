import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:d_project/modals/itemModal.dart';

class CardData with ChangeNotifier{

  CardData(){
    getCardData();
  }

   void getCardData() async{
    print("GetCardData Called");
    var url = 'http://13.127.202.246/api/get_cart';
    var response = await http.post(url, body: {
      "user_id" : "1",
    });
    var data = json.decode(response.body);
    if(data["error"] != true){
      var rest = data['items'] as List;
      List<CartItemModal> itemList = rest.map<CartItemModal>((json) => CartItemModal.fromJson(json)).toList();
      for (int j = 0; j < itemList.length; j++){
        CartItemModal i = itemList[j];
        cartItems[i.upcCode] = i.qty;
      }
      print(cartItems);
    }
  }

  Map<String , int> cartItems = {};

  void addToCart(String upcCode) {
    if (cartItems.containsKey(upcCode)) {
      cartItems[upcCode] += 1;
    } else {
      cartItems[upcCode] = 1;
    }
    updateCart(upcCode,cartItems[upcCode]);
    notifyListeners();
  }



  void clear(String upcCode) {
      cartItems.remove(upcCode);
      notifyListeners();
      updateCart(upcCode,0);
  }



  void reduceToCart(String upcCode) {
    if (cartItems.containsKey(upcCode)) {
      if(cartItems[upcCode] > 0){
        cartItems[upcCode] -= 1;
        updateCart(upcCode,cartItems[upcCode]);
      }
      if(cartItems[upcCode] == 0){
        clear(upcCode);
      }
    } else {
      clear(upcCode);
    }
    notifyListeners();
  }

  double calculateTotalPrice(){
    return 0;
    var list = cartItems.keys.toList();
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
    // totalPrice += list[i].ourPrice * cartItems[list[i]];
    }
    return totalPrice;
  }

  int cartSize(){
    return cartItems.length;
  }

  double calculateSaving(){
    return 0;
    double offerPrice = calculateTotalPrice();
    var list = cartItems.keys.toList();
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
     // totalPrice += list[i].marketPrice * cartItems[list[i]];
    }
    return totalPrice - offerPrice;

  }


  void updateCart(String upcCode, int qty) async{
    var url = 'http://13.127.202.246/api/update_cart';
    try{
      var response = await http.post(url, body: {
        "user_id" : "1",
        "item_upc" : upcCode,
        "qty" : qty.toString(),
      });
    }
    catch(e){
      print(e);
    }
    print("Cart Updated");
}

}



class CartItemModal{
  String upcCode;
  String itemName;
  int qty;

  CartItemModal({
    this.upcCode,
    this.qty,
    this.itemName
  });

  factory CartItemModal.fromJson(Map<String, dynamic> json) {
    return CartItemModal(
        upcCode: json["item_upc"],
        itemName :  json["item_name"],
        qty : json["item_qty"]);
  }


}