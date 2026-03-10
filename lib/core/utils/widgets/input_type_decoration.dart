import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/app_colors.dart';
import 'inter_text.dart';


InputDecoration buildInputDecoration({
  required String hintText,
  required String labelText,
}) {
  return InputDecoration(
    prefixIcon: null,
    hintText: hintText,
    labelText: labelText,
    errorStyle: regularStyle(AppColors.reddishColor, 14.0, FontWeight.normal),
    labelStyle: regularStyle(AppColors.lightGreyColor, 14.0, FontWeight.normal),
    hintStyle: regularStyle(AppColors.lightGreyColor, 14.0, FontWeight.normal),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    errorBorder: errorBorder(16),
    enabledBorder: myInputBorder(16),
    focusedBorder: myFocusBorder(16),
  );
}


OutlineInputBorder myInputBorder(double circularValue) {
  //return type is OutlineInputBorder
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(circularValue)),
      borderSide: BorderSide(
        color: AppColors.formBoxBorderColor,
        width: 0.5,
      ));
}

OutlineInputBorder errorBorder(double circularValue) {
  //return type is OutlineInputBorder
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(circularValue)),
      borderSide: BorderSide(
        color: Colors.red,
        width: 0.5,
      ));
}

OutlineInputBorder myFocusBorder(double circularValue) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(circularValue)),
      borderSide: BorderSide(
        color: AppColors.buttonColor,
        width: 0.5,
      ));
}

InputDecoration searchDecoration({
  String? prefixIcon,
  required String labelText,
  required Widget suffixIcon,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon != null
        ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              prefixIcon,
              width: 10,
            ))
        : null,
    labelText: labelText,
    suffixIcon: suffixIcon,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    labelStyle: regularStyle(AppColors.lightGreyColor, 14.0, FontWeight.normal),
    hintStyle: regularStyle(AppColors.lightGreyColor, 14.0, FontWeight.normal),
    contentPadding: EdgeInsets.symmetric(vertical: 15),
  );
}
