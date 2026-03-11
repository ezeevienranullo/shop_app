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
  final quantityController = TextEditingController();
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

    quantityController.text = '1';

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
          Row(
          children: [
            Flexible(child: TextField(
              controller: priceController,
              decoration:  buildInputDecoration(hintText: '99.00', labelText: 'Price',),
              keyboardType: TextInputType.number,
            ),),
            SizedBox(width: 5,),
            Flexible(child: TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: buildInputDecoration(hintText: 'Quantity', labelText: 'Quantity',),
            ),),
          ],
        ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed:() {
                  if(priceController.text.isNotEmpty) {
                    final item = Item(
                      name: itemController.text,
                      price: double.parse(priceController.text),
                      totalPrice:((double.parse(priceController.text.isNotEmpty
                          ? priceController.text
                          : '0') * double.parse(quantityController.text.isNotEmpty
                          ? quantityController.text
                          : '1'))),
                      quantity: double.parse(quantityController.text.isNotEmpty ? quantityController.text : '1'),
                    );
                    context.read<ItemBloc>().add(
                      AddItemEvent(item),
                    );
                    itemController.clear();
                    priceController.clear();
                    quantityController.text = '1';
                  }
                },
                child: InterText.bold('ADD ITEM', Colors.black, 14),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: openScanner,
                child:InterText.bold('SCAN', Colors.black, 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                            price: item.price.toString(),
                            context: context,
                            totalPrice: '${item.totalPrice}',
                            quantity: '${item.quantity}');
                      },
                    );
                  },
                ),
              ),
          BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    InterText.regular("Total Items: ${state.totalItems}", Colors.black54, 14),
                    InterText.bold("Total Price: ₱ ${formatAmount(state.totalPrice.toString())}", Colors.black, 16),
                  ],
                ),
              );
            },
          )
        ],
      ),)
    );


  }

}

