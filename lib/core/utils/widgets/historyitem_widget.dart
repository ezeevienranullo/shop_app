import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/core/utils/constant/app_colors.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';
import 'package:shop_app/domain/entities/session.dart';
import 'package:shop_app/presentation/bloc/item_bloc.dart';
import 'package:shop_app/presentation/bloc/item_event.dart';
import 'package:shop_app/presentation/bloc/session_bloc.dart';
import 'package:shop_app/presentation/screens/session_history_screen.dart';

import '../../../presentation/bloc/session_event.dart';

Widget historyItemWidget({
  required BuildContext context,
  required Session session,
}) {

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionHistoryScreen(session: session),
          ));
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterText.extraBold(session.name, AppColors.whiteColor, 14),
              SizedBox(height: 5,),
              InterText.regular(DateFormat('MM/dd/yy - hh:mm a').format(session.date), AppColors.whiteColor, 12),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 5,),
              InterText.extraBold('${session.totalPrice}', AppColors.whiteColor, 12,),
              InterText.regular('Total price', AppColors.whiteColor, 12),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 5,),
              InterText.extraBold('${session.totalItem}', AppColors.whiteColor, 12),
              InterText.regular('Items', AppColors.whiteColor, 12),
            ],
          ),
          Spacer(),
          InkWell(
            onLongPress: () {
              context.read<SessionBloc>().add(DeleteSessionEvent(session.id!));
              context.read<ItemBloc>().add(DeleteItemBySessionIdEvent(session.sessionId));
            },
            child: Icon(Icons.delete, color: AppColors.whiteColor, size: 25),
          ),
        ],
      ),
    ),
  );
}


