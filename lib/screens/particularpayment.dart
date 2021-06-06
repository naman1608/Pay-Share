// @dart=2.9
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
          out.add(Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            child: Card(
              margin: EdgeInsets.fromLTRB(1, 1, 1, 1), // card margin
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 11, 0, 0),
                          child: Text(
                            element.date.day.toString() +
                                '/' +
                                element.date.month.toString() +
                                '/' +
                                element.date.year.toString() +
                                ' ' +
                                element.reason,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.values[3],
                            ),
                          ),
                        ),
                        if (element.amount < 0)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 20),
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
                        else if (element.amount > 0)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 20),
                            child: Text(
                              'Give',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.values[2],
                                fontFamily: 'Lato-Light',
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 20),
                            child: Text(
                              'Balanced',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.values[2],
                                fontFamily: 'Lato-Light',
                              ),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 15, 11, 0),
                          child: Text(
                            'Rs. ' + element.amount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.values[3],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              for (int i = 0; i < payments.length; i++) {
                                if (payments[i].payee == user) {
                                  for (int j = 0;
                                      j < payments[i].paymentdetails.length;
                                      j++) {
                                    if (payments[i].paymentdetails[j].amount ==
                                            element.amount &&
                                        payments[i].paymentdetails[j].due ==
                                            element.due &&
                                        payments[i].paymentdetails[j].reason ==
                                            element.reason &&
                                        payments[i].paymentdetails[j].date ==
                                            element.date) {
                                      payments[i].paymentdetails.removeAt(j);
                                    }
                                  }
                                }
                              }
                            });
                          },
                          icon: Icon(
                            Icons.done_rounded,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
        backgroundColor: Color(0xFFFCFCFC),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home(payments)));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 25,
          ),
        ),
        elevation: 0,
        title: Transform(
          transform: Matrix4.translationValues(-16, 0.0, 0.0),
          child: Text(
            this.user,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPayment(user, payments)));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black87,
                  size: 26,
                )),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
              SizedBox(
                height: 15,
              )
            ] +
            generator(payments),
      ),
    );
  }
}
