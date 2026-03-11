import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';
import '../../core/utils/constant/app_colors.dart';
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
  final ScrollController _scrollController = ScrollController();
  int? highlightedItemId;

  @override
  void initState() {
    super.initState();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
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
      body: Padding(padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          const SizedBox(height: 10),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child:InterText.bold('# ITEMS', Colors.black54, 14),
                ),
                Expanded(
                  flex: 4,
                  child: InterText.bold('PRICE', Colors.black54, 14, align: TextAlign.right,),
                ),
                Expanded(
                  flex: 4,
                  child: InterText.bold('QTY', Colors.black54, 14, align: TextAlign.right,),
                ),
                Expanded(
                  flex: 4,
                  child: InterText.bold('TOTAL', Colors.black54, 14, align: TextAlign.right,),
                ),
              ]
          ),),
          Flexible(
            flex: 4,
                child: BlocBuilder<ItemBloc, ItemState>(
                  builder: (context, state) {
                    final items = List.of(state.items)
                      ..sort((a, b) => a.id!.compareTo(b.id!));

                    if (items.isNotEmpty) {
                      highlightedItemId = items.last.id;
                      Future.delayed(const Duration(seconds: 6), () {
                        if (mounted) {
                          setState(() {
                            highlightedItemId = null;
                          });
                        }
                      });
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isHighlighted = item.id == highlightedItemId;
                        return AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeOut,
                            color: isHighlighted ? Colors.green.withOpacity(0.3) : Colors.transparent,
                            child:itemWidget(
                            id: item.id,
                            index: index + 1,
                            name: item.name,
                            price: item.price.toString(),
                            context: context,
                            totalPrice: '${item.totalPrice}',
                            quantity: '${item.quantity}',
                            item:item
                            )
                        );
                      },
                    );
                  },
                ),
              ),
          SizedBox(height: 20,),
          BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              return Flexible(
                flex: 1,
                child:Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed:() {
                        showEditBottomSheet(context, _scrollController);
                      },
                      child: InterText.bold('ADD ITEM', Colors.black, 14),
                    ),
                    InterText.bold("TOTAL: ₱ ${formatAmount(state.totalPrice.toString())}", Colors.black, 16, align: TextAlign.right,),
                  ],
                )
                )
              );
            },
          ),
        ],
      ),)
    );
  }
}

void showEditBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    ) {

  final itemController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  quantityController.text = '1';

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeOut,
      );
    }
  }

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
              "Add Item",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: itemController,
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

                  if (itemController.text.isNotEmpty) {
                    final item = Item(
                      name: itemController.text,
                      price: double.parse(priceController.text.isNotEmpty ? priceController.text : '0'),
                      totalPrice: ((double.parse(priceController.text.isNotEmpty
                          ? priceController.text
                          : '0') * double.parse(quantityController.text
                          .isNotEmpty
                          ? quantityController.text
                          : '1'))),
                      quantity: double.parse(quantityController.text.isNotEmpty
                          ? quantityController.text
                          : '1'),
                    );
                    context.read<ItemBloc>().add(
                      AddItemEvent(item),
                    );
                    itemController.clear();
                    priceController.clear();
                    quantityController.text = '1';
                  }
                  Navigator.pop(context);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollToBottom();
                  });
                },
                child: InterText.medium('Confirm', AppColors.textColor, 14),
              ),
            ),
          ],
        ),
      );
    },
  );
}

