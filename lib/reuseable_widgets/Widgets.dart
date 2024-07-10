import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../resourses/colors.dart';

Widget Button(text, double width , {loading = false}) {
  return Container(
    height: 50,
    width: width,
    decoration: BoxDecoration(
      color: MyColors.darkpink,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: (loading)?CircularProgressIndicator(
        color: MyColors.white,
      ): Text(
        '$text',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat',
        ),
      )
    ),
  );
}

Widget Textfields(
    {required String title,
    required bool password,
    required double height,
    required double width,
      required Widget onPress,
      required Iterable<String> autoHint,
      required bool obscureText,
       controller,
      maxline,
       valid,
      maxLength,
    required String hint}) {
  bool obscuringText = obscureText;

  return SizedBox(
    width: width,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: MyColors.textfieldboard,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: height,
          child: TextFormField(
            autofillHints: autoHint,
            maxLines: maxline,
            maxLength: maxLength,
            cursorColor: MyColors.bgBlue,

              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: valid,
              obscureText: obscureText,
              obscuringCharacter: "*",
              decoration: InputDecoration(
errorMaxLines: 2,
                  suffixIcon: password
                      ? (onPress)
                      : null,
                  hintText: hint,
                  errorStyle: TextStyle(fontSize: 10),
                  hintStyle: TextStyle(
                      color: MyColors.textfieldboard.withOpacity(.49),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                  contentPadding:
                      EdgeInsets.fromLTRB(21, 10, 0, 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.black,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.red,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.textfieldboard,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.textfieldboard.withOpacity(.8),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.red,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ))),
        )
      ],
    ),
  );
}
