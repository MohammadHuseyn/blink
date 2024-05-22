import 'item.dart';

class order {
  int order_id;
  String customer;
  String address;
  String? delivery_person = null;
  int? delivery_price = null;
  String? discount;
  double? discount_value;
  double total_price;
  String status;
  List<Item> items = [];

  order({
    required this.address,
    required this.order_id,
    required this.customer,
    required this.total_price,
    required this.discount_value,
    required this.discount,
    required this.items,
    required this.status
  });
}
