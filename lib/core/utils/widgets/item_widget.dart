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

Widget itemWidget({
  required int? id,
  required int index,
  required String price,
  required String name,
  required String totalPrice,
  required String quantity,
  required Item item,
  required BuildContext context,
}) {

  return GestureDetector(
    onTap: () {
      showItemOptions(context, item);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InterText.bold('$index', Colors.black54, 12),),
          Expanded(
              flex: 4,
              child: Text(name, style: GoogleFonts.inter(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w400), maxLines: 1, overflow: TextOverflow.ellipsis,)),
          Expanded(
            flex: 4,
            child: InterText.regular(formatAmount(price), Colors.black, 14, align: TextAlign.right,),),
          Expanded(
            flex: 4,
            child: InterText.regular(formatAmount(quantity), Colors.black, 14, align: TextAlign.right,),),
          Expanded(
            flex: 4,
            child: InterText.bold(formatAmount(totalPrice), Colors.black, 14, align: TextAlign.right,),),
        ],
      ),
    ),
  );
}

void showEditBottomSheet(
    BuildContext context,
    int id,
    String name,
    String price,
    String quantity,
    ) {

  final nameController = TextEditingController(text: name);
  final priceController =
  TextEditingController(text: price.replaceAll("₱", ""));
  final quantityController = TextEditingController(text: quantity);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {

      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const Text(
              "Edit Item",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: buildInputDecoration(
                hintText: "Banana",
                labelText: "Item",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: buildInputDecoration(
                hintText: "99.00",
                labelText: "Price",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: buildInputDecoration(
                hintText: "1",
                labelText: "Quantity",
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  if (priceController.text.isNotEmpty) {

                    final priceValue = double.parse(priceController.text);
                    final quantityValue = double.parse(
                        quantityController.text.isNotEmpty
                            ? quantityController.text
                            : '1');

                    final totalPrice = priceValue * quantityValue;

                    context.read<ItemBloc>().add(
                      UpdateItemEvent(
                        id,
                        nameController.text,
                        priceValue,
                        totalPrice,
                        quantityValue,
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                child: InterText.medium('Save', AppColors.textColor, 14),
              ),
            ),

          ],
        ),
      );
    },
  );
}

void showItemOptions(BuildContext context, Item item) {

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {

      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),
            InterText.medium(item.name, Colors.black87, 18),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.green),
              title: const Text("Edit Item"),
              onTap: () {
                Navigator.pop(context);
                showEditBottomSheet(context, item.id!, item.name, item.price.toString(), item.quantity.toString());
              },
            ),

            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete Item"),
              onTap: () {
                context.read<ItemBloc>().add(DeleteItemEvent(item.id!));

                Navigator.pop(context);

              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
