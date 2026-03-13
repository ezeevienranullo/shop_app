import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/widgets/inter_text.dart';
import 'package:shop_app/presentation/bloc/session_bloc.dart';
import 'package:shop_app/presentation/bloc/session_state.dart';
import 'package:shop_app/presentation/screens/session_screen.dart';
import '../../core/utils/constant/app_colors.dart';
import '../../core/utils/widgets/historyitem_widget.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        toolbarHeight: 65,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18.0))),
          title: InterText.extraBold("Grocery Calculator", AppColors.primaryColor, 18),
          actionsPadding: EdgeInsets.only(right: 10),
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: AppColors.primaryColor,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                splashColor: Colors.white24,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionScreen(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: BlocBuilder<ItemBloc, ItemState>(
                      builder: (context, state) {
                        final items = List.of(state.items)
                        .where((item)=> item.sessionId == null).toList();
                        return InterText.extraBold(items.isNotEmpty ? 'Continue' : 'Start New',
                          AppColors.whiteColor, 14, align: TextAlign.center,);
                      },
                    )
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Flexible(
              flex: 4,
              child: BlocBuilder<SessionBloc, SessionState>(
                builder: (context, state) {
                  final sessions = List.of(state.sessions)
                    ..sort((a, b) => b.id!.compareTo(a.id!));
                  return ListView.builder(
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      final session = sessions[index];
                      return historyItemWidget(
                          context: context,
                        session: session
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        )
    );
  }
}

