import 'comment.dart';

class Item {
  int count = 0;
  int quantity = 0;
  String image = "";
  String desc;
  double rate;
  late String sotreid;
  late String id;
  late String name;
  late double price;
  List<Comment> comments = [];
  Item(
      {required this.sotreid,
        required this.id,
        required this.rate,
        required this.name,
        required this.desc,
        required this.image,
        required this.price});
}