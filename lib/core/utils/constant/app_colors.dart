import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = HexColor("#FF5A5A");
  static Color secondaryColor = HexColor("#FF8B5A");
  static Color accentColor = HexColor("#FFD45A");
  static Color scaffoldColor = HexColor("#F5F7F7");
  static Color splashScreenColor = HexColor("#6A7EB4");
  static Color titleColor = HexColor("#34446E");
  static Color labelColor = HexColor("#6A7EB4");
  static Color blueishColor = HexColor("#34446E");
  static Color lightDefaultColor = HexColor("#FEF2DD");
  static Color lightAppBackgroundColor = HexColor("#EFF0F1");
  static Color whiteColor = HexColor("#FFFFFF");
  static Color blackColor = HexColor("#000000");
  static Color blackishColor = HexColor("#11182C");
  static Color lightGreyColor = HexColor("#929BB2");
  static Color lightGreyishColor = HexColor("#EFF0F1");
  static Color subtitleColor = HexColor("#959DB4");
  static Color textColor = HexColor("#202C4B");
  static Color textLighterColor = HexColor("#6A7EB4");
  static Color lightGreenColor = HexColor("#C9FFED");
  static Color reddishColor = HexColor("#dd002b");
  static Color greenColor = HexColor("#03C94F");
  static Color lightGreenBgColor = HexColor("#A8FFD2");
  static Color lightBiscuitColor = HexColor("#FFEED0");
  static Color lightPinkColor = HexColor("#FDBFB4");
  static Color lightBlueColor = HexColor("#A1C3CC");
  static Color lighterBlueColor = HexColor("#DEE5F8");
  static Color buttonColor = HexColor("#03a0bc");
  static Color cardInsideColor = HexColor("#EFFBF6");
  static Color yellowColor = HexColor("#FFC32F");

  static Color DarkPurpleColor = HexColor("#6A7EB4");
  static Color lightBrownColor = HexColor("#F0E8DA");
  static Color DarkBrownColor = HexColor("#A8763C");
  static Color lightGeenColor = HexColor("##D4F0EA");
  static Color DarkGreenColor = HexColor("#20D398");
  static Color LightLipstickColor = HexColor("#F7E3E5");
  static Color DarkLipstickColor = HexColor("##E2717D");

  static Color blueColor = HexColor("#007FFF");
  static Color visaCompletedColor = HexColor("#959DB4");
  static Color visaPendingColor = HexColor("#8D99B1");
  static Color VisaPendingTitleColor = HexColor("#34446E");
  static Color cardTitleColor = HexColor("#34446E");
  static Color forgotPassSuccessBgColor = HexColor("#CCFAE1");
  static Color cardBoxShadow = HexColor("#EBF0F3");
  static Color bottomBarBgColor = HexColor("#a5d3dc");
  static Color bottomBarSelectedColor = HexColor("#00675b");

  static Color formBoxDisplayColor = HexColor("#F4F4F4");
  static Color formBoxBorderColor = HexColor("#E3E3F2");

  static Color backgroundColor = HexColor("#F5F7F7");
  static Color chipBgColor = HexColor("#D6FFD6");
  static Color chatBgColor = HexColor("#F0F8FF");

  static Color badgeColor = HexColor("#6785FF");

  static Color notifLetterColor = HexColor("#fbf3fe");
  static Color notifInvoiceColor = HexColor("#f3fffd");
  static Color notifOnboardingColor = HexColor("#fff9f1");
  static Color notifSupportColor = HexColor("##f7f6fe");
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
