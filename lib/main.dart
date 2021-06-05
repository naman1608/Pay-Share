// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/screens/home.dart';

import 'models/paymentdetails.dart';

void main() {
  runApp(MyApp());
}

List<PaymentDetails> payment = [
  PaymentDetails(
      "Naman Dhingra",
      [ParticularPayment(140, "Party", -1), ParticularPayment(200, "Loan", 1)],
      60),
  PaymentDetails("Aditya Singh", [ParticularPayment(1000, "Cab", -1)], -1000),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Share',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(payment),
    );
  }
}
