// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/models/payment.dart';
import 'package:pay_share/models/paymentdetails.dart';
import 'package:pay_share/screens/addpayee.dart';
import 'package:pay_share/screens/particularpayment.dart';
import 'package:pay_share/screens/wrapper.dart';
import 'package:pay_share/services/auth.dart';

class Home extends StatefulWidget {
  List<PaymentDetails> payments;
  Home(this.payments);
  @override
  _HomeState createState() => _HomeState(this.payments);
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  List<PaymentDetails> payments;
  _HomeState(this.payments);

  List<Widget> generator(List<PaymentDetails> s) {
    List<Widget> out = [];
    if (s == []) return out;
    s.forEach((element) {
      Color c1;
      if (out.length % 3 == 0)
        c1 = Color(0xFFD82D40);
      else if (out.length % 3 == 1)
        c1 = Color(0xFF90AF17);
      else
        c1 = Color(0xFF2DBBD8);
      out.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Details(element.payee, s)));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 6, 10, 6), // card padding
          child: Card(
            margin: EdgeInsets.fromLTRB(1, 1, 1, 1), // card margin
            color: c1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1, 1, 1, 1), // row padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 14, 0, 0), // name padding
                        child: Text(
                          element.payee,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.values[3],
                          ),
                        ),
                      ),
                      if (element.sum < 0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10, 4, 0, 20), // due padding
                          child: Text(
                            'Due',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.values[2],
                              fontFamily: 'Lato-Light',
                            ),
                          ),
                        )
                      else if (element.sum > 0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10, 4, 0, 20), // give padding
                          child: Text(
                            'Give',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.values[2],
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              10, 4, 0, 20), // balanced padding
                          child: Text(
                            'Balanced',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.values[2],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 8, 18, 0),
                        child: Text(
                          'Rs. ' + element.sum.abs().toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.values[3],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 0, 6, 0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              for (int i = 0; i < payments.length; i++) {
                                if (payments[i].payee == element.payee) {
                                  payments.removeAt(i);
                                }
                              }
                            });
                          },
                          icon: Icon(
                            Icons.done_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    });
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Pay Share',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPayee(payments)));
              },
              icon: Icon(
                Icons.add,
                size: 20,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              },
              icon: Icon(
                Icons.logout_rounded,
                size: 20,
                color: Colors.black,
              ))
        ],
        backgroundColor: Color(0xFFF6F6F6),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFF6F6F6),
        child: ListView(
          children: generator(payments),
        ),
      ),
    );
  }
}
