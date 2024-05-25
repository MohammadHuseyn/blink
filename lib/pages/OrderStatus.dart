import 'package:blink/global.dart' as global;
import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {
  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  double delivery_price = 0.0;
  bool fast = false;
  String status = "";
  String? discount = "۰";
  double total_price = 0.0;
  bool got_data = false;

  @override
  void initState() {
    _load_order_status(order_id: global.order_id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () async {
              _load_order_status(order_id: global.order_id);
            },
            child: Icon(
              Icons.refresh,
              size: 50,
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xFF256F46))),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF256F46),
      ),
      body: !got_data
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.lightGreen,
                    color: Color(0xFF256F46),
                    strokeWidth: 5,
                    strokeAlign: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "در حال دریافت وضعیت سفارش",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 25, color: Color(0xFF256F46)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage("images/deliverd.png"),
                      size: 40,
                      color: status == "DELIVERED"
                          ? Color(0xFF256f46)
                          : Color(0xFFCFDED6),
                    ),
                    Text(
                      " ... ",
                      style: TextStyle(
                        fontSize: 30,
                        color: status == "DELIVERED"
                            ? Color(0xFF256f46)
                            : Color(0xFFCFDED6),
                      ),
                    ),
                    ImageIcon(
                      AssetImage("images/delivery.png"),
                      size: 40,
                      color: status == "DELIVERED" || status == "DISPATCHED"
                          ? Color(0xFF256f46)
                          : Color(0xFFCFDED6),
                    ),
                    Text(
                      " ... ",
                      style: TextStyle(
                        fontSize: 30,
                        color: status == "DELIVERED" || status == "DISPATCHED"
                            ? Color(0xFF256f46)
                            : Color(0xFFCFDED6),
                      ),
                    ),
                    ImageIcon(
                      AssetImage("images/packing.png"),
                      size: 40,
                      color: status == "DELIVERED" ||
                              status == "DISPATCHED" ||
                              status == "PROCESSING"
                          ? Color(0xFF256f46)
                          : Color(0xFFCFDED6),
                    ),
                    Text(
                      " ... ",
                      style: TextStyle(
                          fontSize: 30,
                          color: status == "DELIVERED" ||
                              status == "DISPATCHED" ||
                              status == "PROCESSING"
                              ? Color(0xFF256f46)
                              : Color(0xFFCFDED6)),
                    ),
                    ImageIcon(
                      AssetImage("images/boxing.png"),
                      size: 40,
                      color:
                      status == "DELIVERED" ||
                          status == "DISPATCHED" ||
                          status == "PROCESSING" || status == "PENDING"? Color(0xFF256f46) : Color(0xFFCFDED6),
                    )
                  ],
                ),
                Expanded(child: Container()),
                Text(
                  status == "PENDING"
                      ? "در انتظار تایید فروشگاه"
                      : status == "PROCESSING"
                          ? "در حال آماده‌سازی محصول"
                          : status == "DISPATCHED"
                              ? "ارسال محصول توسط پیک"
                              : "تحویل داده شد",
                  style: TextStyle(fontSize: 25, color: Color(0xFF256F46)),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFEAF3EE),
                        borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.all(20.0),
                    child: Table(
                      border: TableBorder.all(color: Colors.transparent),
                      textDirection: TextDirection.rtl,
                      children: [
                        TableRow(
                          children: [
                            Container(
                              height: 50,
                              child: Text(
                                'مالیات',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                'رایگان',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              height: 50,
                              child: Text(
                                'بسته‌بندی',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                'رایگان',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              height: 50,
                              child: Text(
                                'هزینه ارسال',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                global.toPersianNumbers(delivery_price),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              height: 50,
                              child: Text(
                                'تحویل سریع',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                fast? '✓' : '╳',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              height: 50,
                              child: Text(
                                'تخفیف',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                discount == null ? "۰ تومان" : global.toPersianNumbers(double.parse(discount!)),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              height: 50,
                              child: Text(
                                'جمع کل',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                global.toPersianNumbers(total_price + delivery_price),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'shabnam',
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
    );
  }

  Future<void> _load_order_status({required int order_id}) async {
    setState(() {
      got_data = false;
    });
    var res =
        global.getRequestMap("/order_status/?order_id=$order_id");
    Map<String, dynamic> data = await res;
    setState(() {
      delivery_price = double.parse(data["order"]["delivery_price"]);
      fast = data["order"]["fast_delivery"];
      discount = data["order"]["discount_value"];
      total_price = double.parse(data["order"]["total_price"]);
      status = data["order"]["status"];
      got_data = true;
    });
    if (data["order"]["status"] == "DELIVERED") {
      global.currentCardPayement = false;
      global.card.clear();
      global.sum = 0.0;
      global.order_id = null;
    }
  }
}
