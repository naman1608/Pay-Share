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

  var currencies = ["Due", "Give"];

  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime date = DateTime.now();
  String reason = '';
  String amount = '';
  String borroworlend = 'Due';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(user, paymentlist)));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 21,
          ),
        ),
        title: Transform(
          transform: Matrix4.translationValues(-16, 0.0, 0.0),
          child: Text(
            'Add Record',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: Color(0xFFFCFCFC),
      ),
      body: Container(
        color: Color(0xFFFCFCFC),
        padding: EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 45,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  height: 50,
                  child: TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Reason'),
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
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  child: TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Amount'),
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
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          isDense: true,
                          prefixText: 'Due or Give   ',
                          prefixStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 15,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 15,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFBFBFBF),
                              width: 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFBFBFBF),
                              width: 1.2,
                            ),
                          ),
                          fillColor: Color(0xFFF9F9F9),
                          hintStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 15,
                          ),
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Please select expense',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: borroworlend,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                borroworlend = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  child: TextFormField(
                    cursorColor: Color(0xFF9E9E9E),
                    onSaved: (val) {
                      date = selectedDate;
                    },
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: "Date",
                      icon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return "Please enter a date for your task";
                      return null;
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
                        for (int i = 0; i < paymentlist.length; i++) {
                          if (paymentlist[i].payee == user) {
                            paymentlist[i].paymentdetails.add(ParticularPayment(
                                  int.parse(amount),
                                  reason,
                                  (borroworlend == 'Due' ? 1 : -1),
                                  date,
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        'Add Record',
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
