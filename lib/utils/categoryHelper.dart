import 'package:d_project/modals/categoryModal.dart';
import 'package:flutter/material.dart';
import 'package:d_project/modals/subCategoryModal.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Category> categories = [
  Category(color: Color(0XFF43A047),icon : 'assests/icon/food.svg',name : "Fruits & Vegetables",subCategories: [
    subCategory(name: "Fruits", color: Colors.orange, icon: 'assests/icon/fruitsAndVegetables/fruit.svg'),
    subCategory(name: "Vegetables", color: Colors.green, icon: 'assests/icon/fruitsAndVegetables/farm.svg'),
  ]),
  Category(color: Color(0XFFE74C3C),icon : 'assests/icon/market.svg',name : "Groceries",subCategories: [
    subCategory(name: "Dryfruits", color: Colors.orange, icon: 'assests/icon/groceries/almond.svg'),
    subCategory(name: "Oil & Ghee", color: Colors.green, icon: 'assests/icon/groceries/olive-oil.svg'),
    subCategory(name: "Flour & Pulses", color: Colors.white, icon: 'assests/icon/groceries/flour.svg'),
    subCategory(name: "Pulses", color: Colors.blue, icon: 'assests/icon/groceries/bento.svg'),
    subCategory(name: "Spices", color: Colors.orange, icon: 'assests/icon/groceries/spices.svg'),
    subCategory(name: "Salt & Sugar", color: Colors.brown, icon: 'assests/icon/groceries/seasoning.svg'),

  ]),
  Category(color: Color(0XFFACF1F3),icon : 'assests/icon/milk.svg',name : "Dairy",subCategories: [
    subCategory(name: "Milk", color: Colors.orange, icon: 'assests/icon/dairy/milk.svg'),
    subCategory(name: "Milk Powder", color: Colors.green, icon: 'assests/icon/dairy/powder.svg'),
    subCategory(name: "Coffee", color: Colors.white, icon: 'assests/icon/dairy/breakfast.svg'),
    subCategory(name: "Paneer", color: Colors.blue, icon: 'assests/icon/dairy/spinach.svg'),
    subCategory(name: "Butter", color: Colors.orange, icon: 'assests/icon/dairy/butter.svg'),
  ]),


  //Undone below it
  Category(color: Color(0XFF2962FF),icon : 'assests/icon/clean.svg',name : "Household & Cleaning",subCategories: [
    subCategory(name: "Air Freshner", color: Colors.orange, icon: 'assests/icon/cleaningAndHousehold/air-freshner.svg'),
    subCategory(name: "DeterGents & Bars", color: Colors.green, icon: 'assests/icon/cleaningAndHousehold/detergent.svg'),
    subCategory(name: "Cleaning Tools", color: Colors.white, icon: 'assests/icon/cleaningAndHousehold/wash.svg'),
  ]),
  Category(color: Color(0XFFE4A57B),icon : 'assests/icon/personal-care.svg',name : "Personal & Hygiene",subCategories: [
    subCategory(name: "Cosmetic", color: Colors.orange, icon: 'assests/icon/personalCare/makeup.svg'),
    subCategory(name: "Deos & Perfumes", color: Colors.green, icon: 'assests/icon/personalCare/perfume.svg'),
    subCategory(name: "Oral & Healthcare", color: Colors.white, icon: 'assests/icon/personalCare/dentist.svg'),
    subCategory(name: "Personal Hygiene", color: Colors.blue, icon: 'assests/icon/personalCare/personalCare.svg'),
    subCategory(name: "Sanitory Pads", color: Colors.orange, icon: 'assests/icon/personalCare/period.svg'),
    subCategory(name: "Skin and Shaving needs", color: Colors.brown, icon: 'assests/icon/personalCare/shave.svg'),

  ] ),
  Category(color: Color(0XFFFF6600),icon : 'assests/icon/coke.svg',name : "Food & Beverages",subCategories: [
    subCategory(name: "Choclates & Candies", color: Colors.orange, icon: 'assests/icon/groceries/almond.svg'),
    subCategory(name: "Jams & Spreads", color: Colors.green, icon: 'assests/icon/groceries/olive-oil.svg'),
    subCategory(name: "Flour & Pulses", color: Colors.white, icon: 'assests/icon/groceries/flour.svg'),
    subCategory(name: "Pulses", color: Colors.blue, icon: 'assests/icon/groceries/bento.svg'),
    subCategory(name: "Spices", color: Colors.orange, icon: 'assests/icon/groceries/spices.svg'),
    subCategory(name: "Salt & Sugar", color: Colors.brown, icon: 'assests/icon/groceries/seasoning.svg'),

  ]),
  Category(color: Colors.orange,icon : 'assests/icon/item.svg',name : "View all", subCategories: null),
];









//Return the category object on calling with the name of respective category
Category returnCategoryWithName(String name){
    for(int i = 0 ; i < categories.length; i++){
      if(categories[i].name == name){
        return categories[i];
      }
    }
    return categories[categories.length - 1];
}