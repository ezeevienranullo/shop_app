import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'inter_text.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final double? btnHeight;
  final Color? borderColor;
  final bool isBusy;

  const Button({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.btnHeight,
    this.borderColor,
    required this.isBusy,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? AppColors.primaryColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: btnHeight ?? 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
            Border.all(color: borderColor ?? Colors.transparent, width: 1),
          ),
          child: isBusy
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
              : InterText.semiBold(text, textColor ?? Colors.white, 14.0),
        ),
      ),
    );
  }
}
