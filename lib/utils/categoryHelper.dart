import 'package:d_project/modals/categoryModal.dart';
import 'package:flutter/material.dart';
import 'package:d_project/modals/subCategoryModal.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Category> categories = [
  Category(color: Color(0XFF43A047),icon : 'assests/icon/food.svg',name : "Fruits & Vegetables", searchToken : "fruits" , subCategories: [
    subCategory(name: "Fruits",searchToken: "fruits", color: Colors.orange, icon: 'assests/icon/fruitsAndVegetables/fruit.svg'),
    subCategory(name: "Vegetables",searchToken: "vegetable",color: Colors.green, icon: 'assests/icon/fruitsAndVegetables/farm.svg'),
  ]),
  Category(color: Color(0XFFE74C3C),icon : 'assests/icon/market.svg',name : "Groceries",searchToken : "groceries" , subCategories: [
    subCategory(name: "Dryfruits", searchToken : "dry",color: Colors.orange, icon: 'assests/icon/groceries/almond.svg'),
    subCategory(name: "Oil & Ghee", searchToken : "oil" ,color: Colors.green, icon: 'assests/icon/groceries/olive-oil.svg'),
    subCategory(name: "Flour & Pulses",searchToken: "flour", color: Colors.white, icon: 'assests/icon/groceries/flour.svg'),
    subCategory(name: "Pulses",searchToken: "pulses", color: Colors.blue, icon: 'assests/icon/groceries/bento.svg'),
    subCategory(name: "Spices",searchToken: "spices", color: Colors.orange, icon: 'assests/icon/groceries/spices.svg'),
    subCategory(name: "Salt & Sugar",searchToken: "salt", color: Colors.brown, icon: 'assests/icon/groceries/seasoning.svg'),

  ]),
  Category(color: Color(0XFFACF1F3),icon : 'assests/icon/milk.svg',name : "Dairy",searchToken : "dairy" ,subCategories: [
    subCategory(name: "Milk",searchToken: "milk", color: Colors.orange, icon: 'assests/icon/dairy/milk.svg'),
    subCategory(name: "Milk Powder",searchToken: "milk powder", color: Colors.green, icon: 'assests/icon/dairy/powder.svg'),
    subCategory(name: "Coffee",searchToken: "coffee", color: Colors.white, icon: 'assests/icon/dairy/breakfast.svg'),
    subCategory(name: "Paneer",searchToken: "paneer", color: Colors.blue, icon: 'assests/icon/dairy/spinach.svg'),
    subCategory(name: "Butter",searchToken: "butter", color: Colors.orange, icon: 'assests/icon/dairy/butter.svg'),
  ]),


  //Undone below it
  Category(color: Color(0XFF2962FF),icon : 'assests/icon/clean.svg',name : "Household & Cleaning", searchToken:  "household",subCategories: [
    subCategory(name: "Air Freshner",searchToken: "freshner", color: Colors.orange, icon: 'assests/icon/cleaningAndHousehold/air-freshner.svg'),
    subCategory(name: "Detergents & Bars", searchToken : "detergents",color: Colors.green, icon: 'assests/icon/cleaningAndHousehold/detergent.svg'),
    subCategory(name: "Cleaning Tools",searchToken: "cleaning", color: Colors.white, icon: 'assests/icon/cleaningAndHousehold/wash.svg'),
  ]),
  Category(color: Color(0XFFE4A57B),icon : 'assests/icon/personal-care.svg',name : "Personal & Hygiene",searchToken:"personal",subCategories: [
    subCategory(name: "Cosmetic",searchToken: "cosmetic", color: Colors.orange, icon: 'assests/icon/personalCare/makeup.svg'),
    subCategory(name: "Deos & Perfumes", searchToken:"deos",color: Colors.green, icon: 'assests/icon/personalCare/perfume.svg'),
    subCategory(name: "Oral & Healthcare",searchToken: "healthcare", color: Colors.white, icon: 'assests/icon/personalCare/dentist.svg'),
    subCategory(name: "Personal Hygiene",searchToken: "personal", color: Colors.blue, icon: 'assests/icon/personalCare/personalCare.svg'),
    subCategory(name: "Sanitory Pads", searchToken: "sanitory" ,color: Colors.orange, icon: 'assests/icon/personalCare/period.svg'),
    subCategory(name: "Skin and Shaving needs",searchToken: "shaving", color: Colors.brown, icon: 'assests/icon/personalCare/shave.svg'),

  ] ),
  Category(color: Color(0XFFFF6600),icon : 'assests/icon/coke.svg',name : "Food & Beverages",searchToken : "food",subCategories: [
    subCategory(name: "Choclates & Candies",searchToken: "choclates", color: Colors.orange, icon: 'assests/icon/foodAndBeverages/bar.svg'),
    subCategory(name: "Jams & Spreads", searchToken: "jams",color: Colors.green, icon: 'assests/icon/foodAndBeverages/jams.svg'),
    subCategory(name: "Namkeen", searchToken: "namkeen",color: Colors.white, icon: 'assests/icon/foodAndBeverages/namkeen.svg'),
    subCategory(name: "Noodles",searchToken: "noodles", color: Colors.blue, icon: 'assests/icon/foodAndBeverages/noodles.svg'),
    subCategory(name: "Sauce & Pickles",searchToken: "sauce", color: Colors.pink, icon: 'assests/icon/foodAndBeverages/sauce.svg'),
    subCategory(name: "Biscuit & Cookies",searchToken: "biscuit", color: Colors.brown, icon: 'assests/icon/foodAndBeverages/biscuit.svg'),
    subCategory(name: "Frozen fruits & papad",searchToken: "frozen", color: Colors.deepOrangeAccent, icon: 'assests/icon/foodAndBeverages/frozenFruit.svg'),
    subCategory(name: "Ice-creams",searchToken: "ice-cream", color: Colors.brown, icon: 'assests/icon/foodAndBeverages/iceCream.svg'),
    subCategory(name: "Sweets & Cakes",searchToken: "sweets", color: Colors.red, icon: 'assests/icon/foodAndBeverages/cake-pop.svg'),
  ]),
  Category(color: Colors.orange,icon : 'assests/icon/item.svg',name : "View all",searchToken: "", subCategories: null),
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