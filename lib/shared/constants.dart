// @dart=2.9
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintMaxLines: 1,
  //contentPadding: EdgeInsets.fromLTRB(0, -1, 0, -1),
  fillColor: Color(0xFFF9F9F9),
  filled: true,
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
);
