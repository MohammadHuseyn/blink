class Store {
  late String id;
  late String name;
  late int longitude;
  late int latitude;
  late List<Item> items;
  Store({required this.id, required this.name, required this.longitude, required this.latitude, List<Item>? items})
      : items = items ?? [];


}

class Item {
  late String id;
  late String name;
  late int price;
  Item({required this.id, required this.name, required this.price});

}