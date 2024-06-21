import 'package:blink/pages/Payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global.dart' as gloabl;
import 'OrderSubmitted.dart';

class LastCheck extends StatefulWidget {
  LastCheck({super.key, required this.sum});
  double sum;

  @override
  State<LastCheck> createState() => _LastCheckState();
}

class _LastCheckState extends State<LastCheck> {
  bool fast = false;
  bool face2facePay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () async {
              // try {
                var res = await gloabl.postRequest({
                  "location_id" : gloabl.addresses[gloabl.addressIndex].id,
                  "store_id" : gloabl.store_id,
                  "fast_delivery" : fast,
                  "payment_method" : face2facePay
                }, "/makeorder/");
                Map<String, dynamic> data = await res;
                gloabl.order_id = data["order_id"];
              // } catch(e) {}
              if (face2facePay) {gloabl.currentCardPayement = true;
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderSubmitted()));} else Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(sum: "120000")));
            },
            child: const Text(
              "  ادامه   ",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF256F46))),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Table(
                border: TableBorder.all(color: Colors.transparent),
                textDirection: TextDirection.rtl,
                children: [
                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        child: const Text(
                          'نام',
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
                          gloabl.first_name + " " + gloabl.last_name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                        child: const Text(
                          'شماره تلفن',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: const Text(
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
                        child: const Text(
                          'آدرس',
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
                          gloabl.addresses[gloabl.addressIndex].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        child: const Text(
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
                          gloabl.toPersianNumbers(widget.sum + (fast? 50000 : 0)) + " تومان",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'shabnam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "   تحویل فوری   ",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                    Switch(
                      value: fast,
                      onChanged: (value) {
                        setState(() {
                          fast = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "پرداخت حضوری",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,

                    ),
                    Switch(
                      value: face2facePay,
                      onChanged: (value) {
                        setState(() {
                          face2facePay = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text("با انتخاب گزینه بالا هزینه ارسال دوبرابر می‌شود\n اما سفارش در زمان کمتری به دستتان می‌رسد.",
                textDirection: TextDirection.rtl,
// committing
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
