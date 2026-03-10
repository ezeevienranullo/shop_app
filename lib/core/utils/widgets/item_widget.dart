import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';

import '../../../presentation/bloc/item_bloc.dart';
import '../../../presentation/bloc/item_event.dart';

Widget itemWidget({
  required int? id,
  required String price,
  required String name,
  required BuildContext context,
}) {

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(10),
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Expanded(child: InterText.semiBold(name, Colors.black54, 12),),

        InterText.extraBold(price, Colors.orange, 12),
        SizedBox(width: 10,),
        Row(
          children: [

            GestureDetector(
              onLongPress: () {
                context.read<ItemBloc>().add(DeleteItemEvent(id!));
              },
              child:  Icon(Icons.delete, color: Colors.black12),
            ),

            const SizedBox(width: 10),

            GestureDetector(
              onTap: () {
                _showEditDialog(context, id!, name, price);
              },
              child: Icon(Icons.edit, color: Colors.black12),
            ),

          ],
        )

      ],
    ),
  );
}

void _showEditDialog(
    BuildContext context,
    int id,
    String name,
    String price,
    ) {

  final nameController = TextEditingController(text: name);
  final priceController =
  TextEditingController(text: price.replaceAll("\₱", ""));

  showDialog(
    context: context,
    builder: (_) {

      return AlertDialog(
        title: const Text("Edit Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(controller: nameController),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
            ),

          ],
        ),

        actions: [

          TextButton(
            onPressed: () {

              context.read<ItemBloc>().add(
                UpdateItemEvent(
                  id,
                  nameController.text,
                  double.parse(priceController.text),
                ),
              );

              Navigator.pop(context);

            },
            child: const Text("Save"),
          ),

        ],
      );
    },
  );
}