import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/bloc/item_event.dart';
import 'core/di/service_locator.dart';
import 'presentation/bloc/item_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() {

  setupLocator();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) => getIt<ItemBloc>()..add(LoadItemsEvent()),

      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),

    );

  }

}