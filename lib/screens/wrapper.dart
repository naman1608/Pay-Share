// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/models/user.dart';
import 'package:provider/provider.dart';
import 'authentication/authenticate.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    //print(user);
    // returns either Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home([]);
    }
  }
}
