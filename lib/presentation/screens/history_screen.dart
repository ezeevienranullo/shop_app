import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/item_bloc.dart';
import '../bloc/item_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),

      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {

          if(state.items.isEmpty){
            return const Center(
              child: Text("No purchase history"),
            );
          }

          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {

              final item = state.items[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text("Qty: ${item.quantity}"),
                trailing: Text("₱${item.totalPrice}"),
              );
            },
          );
        },
      ),
    );
  }
}