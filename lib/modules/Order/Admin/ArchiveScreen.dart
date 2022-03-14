// @dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ArchiveOrderScreen extends StatelessWidget {
  const ArchiveOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Conditional.single(


        conditionBuilder: (BuildContext context) => HomeCubit.get(context).listOrder.where((element) => element.orderState.toLowerCase() == 'Archive' ).isNotEmpty,
        widgetBuilder: (BuildContext context) {
          return ListView(
            children: const [
              Text('Archive'),
            ],
          );
        },
        context: context,
        fallbackBuilder: (BuildContext context) => const Center(child: Text('No Archives')),
      ),
    );
  }
}
