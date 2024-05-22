import 'comment.dart';

class Item {
  int count = 0;
  int quantity = 0;
  String image = "";
  late String sotreid;
  late String id;
  late String name;
  late double price;
  List<Comment> comments = [];
  Item(
      {required this.sotreid,
        required this.id,
        required this.name,
        required this.image,
        required this.price});
}