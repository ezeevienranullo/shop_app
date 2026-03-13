import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/widgets/button_widget.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';
import '../../core/utils/constant/app_colors.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/widgets/input_type_decoration.dart';
import '../../core/utils/widgets/item_widget.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/session.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';
import '../bloc/session_bloc.dart';
import '../bloc/session_event.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {

  final itemController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int? highlightedItemId;

  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(LoadItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    quantityController.text = '1';

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InterText.regular('Total Item', AppColors.whiteColor, 16),
                        InterText.bold('Grand Total', AppColors.whiteColor, 16),
                      ],
                    ),
                    BlocBuilder<ItemBloc, ItemState>(
                      builder: (context, state) {
                        return  Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                           InterText.regular(formatAmount(state.items.length.toString()), AppColors.whiteColor, 16, align: TextAlign.right,),
                           InterText.bold(formatAmount(state.totalPrice.toString()), AppColors.whiteColor, 16, align: TextAlign.right)
                        ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child:InterText.bold('# ITEMS', AppColors.secondaryColor, 14),
                    ),
                    Expanded(
                      flex: 3,
                      child: InterText.bold('PRICE', AppColors.secondaryColor, 14, align: TextAlign.right,),
                    ),
                    Expanded(
                      flex: 2,
                      child: InterText.bold('QTY', AppColors.secondaryColor, 14, align: TextAlign.right,),
                    ),
                    Expanded(
                      flex: 2,
                      child: InterText.bold('TOTAL', AppColors.secondaryColor, 14, align: TextAlign.right,),
                    ),
                  ]
                ),
              ),
              Flexible(
                flex: 4,
                child: BlocBuilder<ItemBloc, ItemState>(
                  builder: (context, state) {
                    final items = List.of(state.items)
                      ..sort((a, b) => a.id!.compareTo(b.id!));

                    if (items.isNotEmpty) {
                      highlightedItemId = items.last.id;
                      Future.delayed(const Duration(seconds: 5), () {
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
                            color: isHighlighted ? AppColors.secondaryColor.withOpacity(0.3) : Colors.transparent,
                            child:itemWidget(
                                id: item.id,
                                index: index + 1,
                                context: context,
                                item:item,
                               isEditable: true
                            )
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Button(
                    text: 'ADD ITEM',
                    isBusy: false,
                    textColor: AppColors.whiteColor,
                    onTap: () {
                    showAddBottomSheet(context, _scrollController);
                    },
                  ),
                  SizedBox(height: 12,),
                  Button(
                    text: 'FINISH GROCERY',
                    color: Colors.white,
                    textColor: AppColors.textColor,
                    borderColor: AppColors.primaryColor,
                    onTap: () {
                    if(context.read<ItemBloc>().state.totalItems > 0) {
                      showFinishBottomSheet(context, context
                        .read<ItemBloc>()
                        .state
                        .totalItems, context
                        .read<ItemBloc>()
                        .state
                        .totalPrice);
                    }
                  }, isBusy: false,),
                ],
              ),)
            ],
          ),)
    );
  }
}

void showAddBottomSheet(
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
              child:
              Button(
                text: 'Confirm',
                onTap: () {
                  if (itemController.text.isNotEmpty || priceController.text.isNotEmpty) {
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
                isBusy: false,
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showFinishBottomSheet(
    BuildContext context,
    int totalItem,
    double totalPrice,
    ) {
  final nameController = TextEditingController();
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
              "Finish",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: buildInputDecoration(
                hintText: "SM",
                labelText: "Store",
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child:
              Button(
                text: 'Confirm',
                onTap: () {
                  if (nameController.text.isNotEmpty) {
                    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();

                    final session = Session(
                        name: nameController.text,
                        sessionId: sessionId,
                        date: DateTime.now(),
                        totalItem: totalItem,
                        totalPrice: totalPrice
                    );
                    /// save session
                    context.read<SessionBloc>().add(
                      AddSessionEvent(session),
                    );
                    /// attach session id to items
                    context.read<SessionBloc>().add(
                        UpdateItemsSessionEvent(sessionId)
                    );
                    /// optional clear items
                    context.read<ItemBloc>().add(ClearItemsEvent());
                    nameController.clear();
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                isBusy: false,
              ),
            ),
          ],
        ),
      );
    },
  );
}

