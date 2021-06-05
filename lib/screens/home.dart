// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/models/payment.dart';
import 'package:pay_share/models/paymentdetails.dart';
import 'package:pay_share/screens/addpayee.dart';
import 'package:pay_share/screens/particularpayment.dart';

class Home extends StatefulWidget {
  List<PaymentDetails> payments;
  Home(this.payments);
  @override
  _HomeState createState() => _HomeState(this.payments);
}

class _HomeState extends State<Home> {
  List<PaymentDetails> payments;
  _HomeState(this.payments);

  List<Widget> generator(List<PaymentDetails> s) {
    List<Widget> out = [];
    if (s == []) return out;
    s.forEach((element) {
      out.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Details(element.payee, s)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            margin: EdgeInsets.all(10),
            color: Color(0xffd82d40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        element.payee,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        width: 150,
                      ),
                      Text(
                        element.sum.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      if (element.sum < 0)
                        Text(
                          'Due',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      else if (element.sum > 0)
                        Text(
                          'Give',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      else
                        Text(
                          'Balanced',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      IconButton(
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
                          size: 15,
                          color: Colors.white,
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
          style: TextStyle(fontSize: 25),
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
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: generator(payments),
        ),
      ),
    );
  }
}
