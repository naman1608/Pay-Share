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
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home(paymentlist)));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 21,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFCFCFC),
        /*title: Transform(
          transform: Matrix4.translationValues(-16, 0.0, 0.0),
          child: Text(
            'Add Account',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22,
            ),
          ),
        ),*/
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 45,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: 50,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 15,
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter a valid name';
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
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 305,
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        paymentlist.add(PaymentDetails(payee, [], 0));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(paymentlist)));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        'Add Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
