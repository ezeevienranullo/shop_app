import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/constant/app_colors.dart';
import '../../core/utils/widgets/inter_text.dart';
import '../../core/utils/widgets/item_widget.dart';
import '../../domain/entities/session.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';

class SessionHistoryScreen extends StatelessWidget {
  final Session session;

  const SessionHistoryScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    context.read<ItemBloc>().add(LoadItemsBySessionEvent(session.sessionId));

    return Scaffold(
      appBar: AppBar(
        title: InterText.extraBold(
          'Items in ${session.name}',
          AppColors.primaryColor,
          18,
        ),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(18.0))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            // Header
            Row(
              children: const [
                Expanded(flex: 3, child: Text('# ITEMS')),
                Expanded(flex: 3, child: Text('PRICE', textAlign: TextAlign.right)),
                Expanded(flex: 2, child: Text('QTY', textAlign: TextAlign.right)),
                Expanded(flex: 2, child: Text('TOTAL', textAlign: TextAlign.right)),
              ],
            ),
            const SizedBox(height: 10),

            // List of items
            Expanded(
              child: BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  // Filter items for this session
                  final items = state.items
                      .where((item) => item.sessionId == session.sessionId)
                      .toList();

                  if (items.isEmpty) {
                    return const Center(
                      child: Text("No items found for this session."),
                    );
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return itemWidget(
                        id: item.id,
                        index: index + 1,
                        isEditable: false,
                        context: context,
                        item: item,
                      );
                    },
                  );
                },
              ),
            ),

            // Total summary
            const SizedBox(height: 20),
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                final items = state.items
                    .where((item) => item.sessionId == session.sessionId)
                    .toList();

                final totalPrice =
                items.fold(0.0, (sum, item) => sum + item.totalPrice);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InterText.bold('Total Items: ${items.length}',
                        AppColors.secondaryColor, 16),
                    InterText.bold('Total: $totalPrice', AppColors.primaryColor, 16),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}