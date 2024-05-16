import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'StorePage.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF256F46),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              card(context),
              card(context),
              card(context),
            ],
          ),
        ));
  }
}

card(context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFF256f46), width: 1.5))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    // color: Color(0xffEAF3EE),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                      ),
                      const BoxShadow(
                        color: Color(0xffEAF3EE),
                        spreadRadius: -0.2,
                        blurRadius: 5.0,
                      ),
                    ],
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ImageIcon(
                    AssetImage("images/shop.png"),
                    size: 65,
                  ),
                ),
              ),
              title: Text(
                stores[0].name,
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Row(
                children: [
                  ImageIcon(
                    AssetImage("images/location.png"),
                    color: Color(0xFF97b9a7),
                    size: 30,
                  ),
                  Text("  آدرس انتخاب شده"),
                ],
              ),
              trailing: Text("پیگیری سفارش"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StorePage(store: stores[0])));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.075,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  bottomsheed(context);
                },
                child: Text(
                  "مشاهده فاکتور",
                  style: TextStyle(fontSize: 25),
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
        ],
      ),
    ),
  );
}
void bottomsheed(context) {
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      builder: (builder){
    return Container(
      // height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25)
        )
      ),
      child: StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
        return SingleChildScrollView(
          child: Column(children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 7.5),
            //   child: Container(
            //     height: 7,
            //     width: 150,
            //     decoration: BoxDecoration(
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.circular(25)
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.8,
                // height: 250,
                // color: Color(0xFFEAF3EE),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 15,
                      offset: Offset(0,10)
                    )
                  ],
                  color: Color(0xFFdee8e2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )
                ),
                // color: Colors.red,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                            fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("نام محصول", style: TextStyle(
                            fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                              fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("نام محصول", style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.8,
                // height: 250,
                // color: Color(0xFFEAF3EE),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: Offset(0,10)
                      )
                    ],
                    color: Color(0xFFdee8e2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    )
                ),
                // color: Colors.red,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                              fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("مالیات", style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                              fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("بسته‌بندی", style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                              fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("ارسال", style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                              fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("تحویل سریع", style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                              fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("تخفیف", style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Row(
                        children: [
                          Text("قیمت", style: TextStyle(
                              fontSize: 18
                          ),),
                          Expanded(child: Container()),
                          Text("مبلغ نهایی", style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],),
        );
      }),
    );
    });
}

