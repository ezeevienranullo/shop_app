import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/widgets/input_type_decoration.dart';
import '../../core/utils/widgets/item_widget.dart';
import '../../domain/entities/item.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';
import 'scan_price_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    final itemController = TextEditingController();
  final priceController = TextEditingController();
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    Future<void> openScanner() async {

      final price = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ScanPriceScreen(),
        ),
      );

      if (price != null) {

        priceController.text = price.toString();

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 30,),
        TextField(
              controller: itemController,
              decoration: buildInputDecoration(hintText: 'Banana', labelText: 'Item',),
              textCapitalization: TextCapitalization.words,
            ),
          SizedBox(height: 16,),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: buildInputDecoration(hintText: '99.00', labelText: 'Price',),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final item = Item(
                      name: itemController.text,
                      price: double.parse(priceController.text),
                    );
                    context.read<ItemBloc>().add(
                      AddItemEvent(item),
                    );
                    itemController.clear();
                    priceController.clear();
                  },
                  child:  InterText.regular('Add Item', Colors.black, 16),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: openScanner,
                  child:InterText.regular('Scan', Colors.black, 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {

                  final items = List.of(state.items)
                    ..sort((a, b) => b.id!.compareTo(a.id!));

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return itemWidget(
                          id: item.id,
                          name: item.name,
                          price: "\₱${formatPrice(item.price)}",
                          context: context);
                    },
                  );
                },
              ),
            ),

        BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {

              return Column(
                children: [
                  InterText.regular("Total Items: ${state.totalItems}", Colors.black54, 14),
                  InterText.bold("Total Price: ₱ ${formatPrice(state.totalPrice)}", Colors.black, 16),
                ],
              );

            },
          )
        ],
      ),)
    );


  }

}

