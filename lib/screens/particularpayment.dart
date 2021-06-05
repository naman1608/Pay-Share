import 'package:flutter/material.dart';
import 'package:pay_share/models/payment.dart';
import 'package:pay_share/models/paymentdetails.dart';
import 'package:pay_share/screens/addpayment.dart';
import 'package:pay_share/screens/home.dart';

class Details extends StatefulWidget {
  final String user;
  List<PaymentDetails> payments;
  Details(this.user, this.payments);
  @override
  _DetailsState createState() => _DetailsState(this.user, this.payments);
}

class _DetailsState extends State<Details> {
  final String user;
  List<PaymentDetails> payments;
  _DetailsState(this.user, this.payments);

  List<Widget> generator(List<PaymentDetails> s) {
    List<Widget> out = [];
    for (int i = 0; i < s.length; i++) {
      if (s[i].payee == user) {
        s[i].paymentdetails.forEach((element) {
          out.add(Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(element.reason),
                    Text(element.amount.toString())
                  ],
                ),
                Row(
                  children: [
                    if (element.amount < 0)
                      Text(
                        'Due',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    else if (element.amount > 0)
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
                      onPressed: () {},
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
          ));
        });
      }
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home(payments)));
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(this.user),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPayment(user, payments)));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView(
        children: generator(payments),
      ),
    );
  }
}
