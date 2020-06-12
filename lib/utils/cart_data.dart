import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/utils/listOfItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardData with ChangeNotifier{
  ListOfItems listOfItems = ListOfItems();
  int sumTotal = 0;


  static final CardData _cartData = CardData._internal();

  factory CardData() {
    return _cartData;
  }

  CardData._internal(){
  }


  String userid;
  double totalAmount = 0;
  bool lockCart = false;

   void getCardData() async{
    if(lockCart == false){
      lockCart = true;
      print("GetCardData Called");
      SharedPreferences sharedPreferences;
      sharedPreferences = await SharedPreferences.getInstance();
      userid = sharedPreferences.getString("token").toString();
      print(userid);
      if(userid != null){
        try {
          var url = 'https://purchx.store/api/get_cart';
          var response = await http.post(url, body: {
            "user_id" : userid,
          });
          var data = json.decode(response.body);
          print(data);
          if(data["error"] != "true"){
            if(data["items"] == "Cart is Empty"){
              cartItems.clear();
            }
            if(data["items"] != "Cart is Empty"){
              var rest = data['items'] as List;
              print(rest);
              List<CartItemModal> itemList = rest.map<CartItemModal>((json) => CartItemModal.fromJson(json)).toList();
              for (int j = 0; j < itemList.length; j++){
                CartItemModal i = itemList[j];
                cartItems[i.upcCode] = i.qty;
              }
              print(cartItems);
            }
          }
          else{
            cartItems.clear();
          }
        } on Exception catch (e) {
          print(e);
          lockCart = false;
          cartItems.clear();
        }
      }
      lockCart = false;
    }
  }



  Map<String , int> cartItems = {};
  Future<Map<Item, int>> SyncMaps() async{
    Map<Item, int> mainCartItems = {};
    getCardData();
    cartItems.forEach((k, v) {
      if(v != 0){
        Future<Item> item = getItemWithUpc(k);
        item.then((val){
          print(val.toString());
          if(val != null){
            if(v != 0){
              mainCartItems[val] = v;
            }
          }
        });
      }
    });
    return mainCartItems;
  }

  Future<Item> getItemWithUpc(String upc) async{
    Item item;
    var val = await listOfItems.itemList;
    for(int i = 0 ; i <val.length;i++) {
      if (val[i].upcCode == upc) {
        item = val[i];
      }
      else if(val[i].subCategories){
        for(int j = 0; j < val[i].subItemsList.length;j++){
          if(val[i].subItemsList[j].upcCode == upc){
            Item returnItem = Item();
            returnItem.name = val[i].name;
            returnItem.imagePath = val[i].imagePath;
            returnItem.ourPrice = val[i].subItemsList[j].ouuPrice;
            returnItem.unit = val[i].subItemsList[j].unit;
            returnItem.upcCode =val[i].subItemsList[j].upcCode;
            print("Sub Product Triggered");
            return returnItem;
          }
        }
      }
    }
    return item;
  }

  Future<void> addToCartFut(String upcCode) async {
    print("future called");
    addToCart(upcCode);
  }

  Future<void> reduceToCartFut(String upcCode) async {
    print("future called");
    reduceToCart(upcCode);
  }


  void addToCart(String upcCode) async{
    if (cartItems.containsKey(upcCode)) {
      Future<void> future = updateCart(upcCode, cartItems[upcCode]-1);
      future.then((value) => {
        cartItems[upcCode] += 1,
        // notifyListeners()
        print("check2 : "+cartItems.toString()),
        print(cartItems),
        notifyListeners()
      });
    } 
    else {
      Future<void> future = updateCart(upcCode, 1);
      future.then((value) => {
        cartItems[upcCode] = 1,
        // notifyListeners()
        print("check2 : "+cartItems.toString()),
        print(cartItems),
        notifyListeners()
      });
    }
    // await updateCart(upcCode,cartItems[upcCode]);
    // notifyListeners();
  }



  void clear(String upcCode) async{
      // await updateCart(upcCode,0);
      Future<void> future = updateCart(upcCode, 0);
      future.then((value) => {
        cartItems.remove(upcCode),
        notifyListeners()
      });
  }



  void reduceToCart(String upcCode) async{
    if (cartItems.containsKey(upcCode)) {
      if(cartItems[upcCode] > 1){
        // cartItems[upcCode] -= 1;
        // await updateCart(upcCode,cartItems[upcCode]);
        print("check1 : ");
        print(cartItems);
        Future<void> future = updateCart(upcCode, cartItems[upcCode]-1);
        future.then((value) => {
          cartItems[upcCode] -= 1,
          // notifyListeners()
          print("check2 : "+cartItems.toString()),
          print(cartItems),
          notifyListeners()
        });
      }
      else if(cartItems[upcCode] == 1){
        print("check1 : ");
        print(cartItems);
        // clear(upcCode);
        Future<void> future = updateCart(upcCode, 0);
        future.then((value) => {
          cartItems.remove(upcCode),
          // notifyListeners()
          print("check2 : "+cartItems.toString()),
          print(cartItems),
          notifyListeners()
        });
      }
    } else {
      // clear(upcCode);
      Future<void> future = updateCart(upcCode, 0);
      future.then((value) => {
        cartItems.remove(upcCode),
        notifyListeners()
      });
    }
    print("check");
    // print(cartItems);
    
  }

  Future<double> calculateTotalPrice()  async{
    Map<Item, int> itemListProduct = await SyncMaps();
    double totalPrice = 0;
    var list = itemListProduct.keys.toList();
    if(list.length > 0){
      for (int i = 0; i < list.length; i++) {
        print(i.toString() + " " + list[i].ourPrice.toString() + " " +  itemListProduct[list[i]].toString());
        totalPrice += list[i].ourPrice * itemListProduct[list[i]];
        print("Total Price" + totalPrice.toString());
      }
    }
    return totalPrice;
  }

  Future<int> cartSize() async{
    Map<Item, int> itemListProduct = await SyncMaps();
    return itemListProduct.length;
  }

  double calculateSaving(){
    return 0;
   // double offerPrice = calculateTotalPrice();
    var list = cartItems.keys.toList();
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
     // totalPrice += list[i].marketPrice * cartItems[list[i]];
    }
   // return totalPrice - offerPrice;

  }


  Future<void> updateCart(String upcCode, int qty) async{
    print("update cart called");
    var url = 'https://purchx.store/api/update_cart';
    try{
      var response = await http.post(url, body: {
        "user_id" : userid,
        "item_upc" : upcCode,
        "qty" : qty. toString(),
      });
      print("Add to Cart " + response.body);
    }
    catch(e){
      print(e);
      print("Unable to Update Cart");
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
