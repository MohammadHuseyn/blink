import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

int status = 1;

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                status += 1;
              });
            },
            child: Icon(Icons.refresh, size: 50,),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF256F46))
            ),
          ),
        ),
      ),

      appBar: AppBar(backgroundColor: Color(0xFF256F46),),
      body: Column(
        children: [
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage("images/deliverd.png"),
                size: 50,
                color: status == 4 ? Color(0xFF256f46) : Color(0xFFCFDED6),
              ),
              Text(
                " ... ",
                style: TextStyle(
                  fontSize: 40,
                  color: status == 4 ? Color(0xFF256f46) : Color(0xFFCFDED6),
                ),
              ),
              ImageIcon(
                AssetImage("images/delivery.png"),
                size: 50,
                color: status >= 3 ? Color(0xFF256f46) : Color(0xFFCFDED6),
              ),
              Text(
                " ... ",
                style: TextStyle(
                  fontSize: 40,
                  color: status >= 3 ? Color(0xFF256f46) : Color(0xFFCFDED6),
                ),
              ),
              ImageIcon(
                AssetImage("images/packing.png"),
                size: 50,
                color: status >= 2 ? Color(0xFF256f46) : Color(0xFFCFDED6),
              ),
              Text(
                " ... ",
                style: TextStyle(
                    fontSize: 40,
                    color: status >= 2 ? Color(0xFF256f46) : Color(0xFFCFDED6)),
              ),
              ImageIcon(
                AssetImage("images/boxing.png"),
                size: 50,
                color: status >= 1 ? Color(0xFF256f46) : Color(0xFFCFDED6),
              )
            ],
          ),
          Expanded(child: Container()),
          Text(status == 1
              ? "در انتظار تایید فروشگاه"
              : status == 2
                  ? "در حال آماده‌سازی محصول"
                  : status == 3
                      ? "ارسال محصول توسط پیک"
                      : "تحویل بسته به مشتری",
          style: TextStyle(fontSize: 25, color: Color(0xFF256F46)),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEAF3EE),
                borderRadius: BorderRadius.circular(25)
              ),
              padding: EdgeInsets.all(20.0),
              child: Table(
                border: TableBorder.all(color: Colors.transparent),
                textDirection: TextDirection.rtl,
                children: [
                  TableRow(children: [
                    Container(
                      child: Text(
                        'نام محصول',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'shabnam',
                          fontSize: 20,
                        ),
                      ),
                      height: 50,
                    ),
                    Container(
                      height: 50,
                      child: Text(
                        'قیمت',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'shabnam',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ]),
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
                          'قیمت',
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
                          'قیمت',
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
                          'قیمت',
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
                          'قیمت',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),TableRow(
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
                          'قیمت',
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
                          'قیمت',
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
}
