import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/utils/constant/app_colors.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';

import '../../../domain/entities/item.dart';
import '../../../presentation/bloc/item_bloc.dart';
import '../../../presentation/bloc/item_event.dart';
import '../helpers.dart';
import 'input_type_decoration.dart';

Widget historyItemWidget({
  required BuildContext context,
}) {

  return GestureDetector(
    onTap: () {
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGreyColor.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterText.bold('Session 1 @ Ororama', AppColors.textColor, 14),
              InterText.regular('March 12, 2026', AppColors.subtitleColor, 14),
            ],
          ),
          InterText.extraBold('6,009.65', AppColors.secondaryColor, 16),
        ],
      ),
    ),
  );
}


