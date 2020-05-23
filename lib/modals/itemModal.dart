import 'package:flutter/material.dart';

enum mainCategory{
  fruits,
  vegetables,
  dairy,
  household,
  hygiene,
  food,
}


class Item{


  @override
  String toString() => name;


  Item({this.category,
        this.imagePath,
        this.marketPrice,
        this.name,
        this.ourPrice,
        this.upcCode,
        this.brandName,
        this.itemId,
        this.subItems,
        this.MainCategory,
        this.unit,
        this.MainSubCategory,
  }){
    makeSubCategories();
  }

  String imagePath;
  @required String upcCode;
  @required String name;
  String brandName;
  int itemId;
  double marketPrice;
  double  ourPrice;
  mainCategory category;
  var subItems;
  String MainCategory;
  String MainSubCategory;
  String unit;
  List<subItem> subItemsList = [];
  bool subCategories = false;


  void makeSubCategories(){
    if(subItems != null){
      var rest = subItems as List;
      if(rest.length > 0){
        subCategories = true;
        subItemsList = rest.map<subItem>((json) => subItem.fromJson(json)).toList();
        subItem original = subItem(upcCode: upcCode, ouuPrice: ourPrice, unit: unit);
        subItemsList.add(original);
      }
    }
    else{
      subCategories = false;
    }
  }

  // ignore: missing_return
  Color getColor(){
    Color col;
    switch(this.category){
      case mainCategory.fruits :
        col = Colors.red;
        break;
      case mainCategory.dairy :
        col =  Colors.green;
        break;
      case mainCategory.vegetables :
        col = Colors.white;
        break;
      case mainCategory.household :
        col =  Colors.blue;
        break;
      case mainCategory.hygiene :
        col =  Colors.brown;
        break;
      case mainCategory.food :
        col = Colors.orange;
        break;
    }
    return col;
  }


  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        imagePath: "http://" + json["main_product"]["image_path"],
        subItems :  json["sub_products"],
        itemId :json["item_id"],
        name: json["main_product"]["item_name"],
        ourPrice: json["main_product"]["price_per_unit"],
        brandName: json["main_product"]["brand_name"],
        upcCode: json["main_product"]["item_upc"],
        MainCategory : json["main_product"]["category"],
        unit : json["main_product"]["unit"],
        MainSubCategory: json["main_product"]["sub_category"]
    );
  }
}

//
//"item_id": 144,
//"main_product": {
//"item_upc": "85133268228",
//"item_name": "kismis",
//"brand_name": "85133268228",
//"price_per_unit": 79.0
//},




class subItem{


  String name;
  String brandName;
  double ouuPrice;
  String upcCode;
  String unit;


  subItem({
    this.name,
    this.brandName,
    this.ouuPrice,
    this.upcCode,
    this.unit
});


  factory subItem.fromJson(Map<String, dynamic> json) {
    return subItem(
        name: json["item_name"],
        ouuPrice : json["price_per_unit"],
        brandName: json["brand_name"],
        upcCode: json["item_upc"],
        unit : json["unit"]);
  }
}