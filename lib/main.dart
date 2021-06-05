// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/models/user.dart';
import 'package:pay_share/screens/home.dart';
import 'package:pay_share/screens/wrapper.dart';
import 'package:pay_share/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/paymentdetails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return StreamProvider<CustomUser>.value(
      initialData: CustomUser(uid: ""),
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
