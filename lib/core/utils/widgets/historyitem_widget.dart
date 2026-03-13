import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/constant/app_colors.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';

Widget historyItemWidget({
  required BuildContext context,
}) {

  return GestureDetector(
    onTap: () {
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGreyColor.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterText.extraBold('SM', AppColors.whiteColor, 14),
              SizedBox(height: 5,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InterText.regular('Total Price ', AppColors.whiteColor, 12),
                        InterText.regular('6,009.65', AppColors.whiteColor, 14),
                      ],
                    ),
                  ]
              )
            ],
          ),
          SizedBox(width: 50,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterText.extraBold('Mar 14, 2026', AppColors.whiteColor, 14),
              SizedBox(height: 5,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InterText.regular('Total Items', AppColors.whiteColor, 12),
                        InterText.regular('32', AppColors.whiteColor, 14, align: TextAlign.center,),
                      ],
                    ),
                  ]
              )
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {},
            child: Icon(Icons.delete, color: AppColors.whiteColor, size: 25),
          )
        ],
      ),
    ),
  );
}


