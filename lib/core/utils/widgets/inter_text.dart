import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class InterText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;

  InterText.regular(
    this.text,
    Color textColor,
    double fontSize, {
    Key? key,
    TextAlign align = TextAlign.start,
    bool underline = false,
    bool italic = false,
  })  : style = regularStyle(textColor, fontSize, FontWeight.w400,
            underline: underline, italic: italic,),
        alignment = align,
        super(key: key);

  InterText.medium(
    this.text,
    Color textColor,
    double fontSize, {
    Key? key,
    TextAlign align = TextAlign.start,
    bool underline = false,
        bool italic = false,
  })  : style = mediumStyle(textColor, fontSize, FontWeight.w500,
            underline: underline, italic: italic,),
        alignment = align,
        super(key: key);

  InterText.bold(
    this.text,
    Color textColor,
    double fontSize, {
    Key? key,
    TextAlign align = TextAlign.start,
    bool underline = false,
        bool italic = false,
  })  : style = boldStyle(textColor, fontSize, FontWeight.w700,
            underline: underline, italic: italic),
        alignment = align,
        super(key: key);

  InterText.extraBold(
    this.text,
    Color textColor,
    double fontSize, {
    Key? key,
    TextAlign align = TextAlign.start,
    bool underline = false,
        bool italic = false,
  })  : style = boldStyle(textColor, fontSize, FontWeight.w800,
            underline: underline, italic: italic),
        alignment = align,
        super(key: key);

  InterText.semiBold(
    this.text,
    Color textColor,
    double fontSize, {
    Key? key,
    TextAlign align = TextAlign.start,
    bool underline = false,
        bool italic = false,
  })  : style = semiBoldStyle(textColor, fontSize, FontWeight.w600,
            underline: underline, italic: italic),
        alignment = align,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}

//Font Weight
//Regular w400
//Medium w500
//Semi Bold w600
//Bold w700
//Extra Bold w800
TextStyle regularStyle(Color color, double fontSize, FontWeight weight,
        {bool underline = false, bool italic = false,}) =>
    GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontWeight: weight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );

TextStyle mediumStyle(Color color, double fontSize, FontWeight weight,
        {bool underline = false, bool italic = false}) =>
    GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      fontWeight: weight,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );

TextStyle boldStyle(Color color, double fontSize, FontWeight weight,
        {bool underline = false, bool italic = false,}) =>
    GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      fontWeight: weight,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );

TextStyle semiBoldStyle(Color color, double fontSize, FontWeight weight,
        {bool underline = false, bool italic = false,}) =>
    GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      fontWeight: weight,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );
