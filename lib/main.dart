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
