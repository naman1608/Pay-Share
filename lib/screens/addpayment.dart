// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pay_share/models/paymentdetails.dart';
import 'package:pay_share/screens/particularpayment.dart';
import 'package:pay_share/shared/constants.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class AddPayment extends StatefulWidget {
  final String user;
  List<PaymentDetails> paymentlist;
  AddPayment(this.user, this.paymentlist);

  @override
  _AddPaymentState createState() =>
      _AddPaymentState(this.user, this.paymentlist);
}

class _AddPaymentState extends State<AddPayment> {
  List<PaymentDetails> paymentlist;
  final String user;
  _AddPaymentState(this.user, this.paymentlist);

  final _formKey = GlobalKey<FormState>();
  String reason = '';
  String amount = '';
  String borroworlend = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Add Payment'),
      ),
      body: Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Reason'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter a name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      reason = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Amount'),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter an amount';
                    } else {
                      final number = num.tryParse(val);
                      if (number == null) {
                        return 'Enter a valid amount';
                      } else
                        return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      amount = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropDownFormField(
                  titleText: 'Due or Give',
                  hintText: 'Please choose one',
                  value: borroworlend,
                  onChanged: (value) {
                    setState(() {
                      borroworlend = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Due",
                      "value": "Due",
                    },
                    {
                      "display": "Give",
                      "value": "Give",
                    }
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      for (int i = 0; i < paymentlist.length; i++) {
                        if (paymentlist[i].payee == user) {
                          paymentlist[i].paymentdetails.add(ParticularPayment(
                                int.parse(amount),
                                reason,
                                (borroworlend == 'Due' ? 1 : -1),
                              ));
                          if (borroworlend == 'Due')
                            paymentlist[i].sum -= int.parse(amount);
                          else
                            paymentlist[i].sum += int.parse(amount);
                        }
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Details(user, paymentlist)));
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
