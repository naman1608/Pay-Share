// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/main.dart';
import 'package:pay_share/models/paymentdetails.dart';
import 'package:pay_share/screens/home.dart';
import 'package:pay_share/shared/constants.dart';

class AddPayee extends StatefulWidget {
  List<PaymentDetails> paymentlist;
  AddPayee(this.paymentlist);

  @override
  _AddPayeeState createState() => _AddPayeeState(this.paymentlist);
}

class _AddPayeeState extends State<AddPayee> {
  List<PaymentDetails> paymentlist;
  _AddPayeeState(this.paymentlist);

  final _formKey = GlobalKey<FormState>();
  String payee = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Add User'),
      ),
      body: Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter a name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      payee = val;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      paymentlist.add(PaymentDetails(payee, [], 0));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(paymentlist)));
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
