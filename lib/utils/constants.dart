class Constants {
  static final Constants _singleton = Constants._internal();

  int cartCount;

  factory Constants() {
    return _singleton;
  }

  Constants._internal();
}