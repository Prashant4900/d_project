import 'package:flutter/material.dart';
import 'package:d_project/modals/subCategoryModal.dart';
class Category{
  Category({this.name, this.color, this.icon, this.subCategories,});
  String name;
  Color color;
  String icon;
  List<subCategory> subCategories;
}