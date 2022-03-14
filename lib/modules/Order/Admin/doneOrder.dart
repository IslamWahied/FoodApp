// @dart=2.9
import 'package:elomda/bloc/home_bloc/HomeCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class DoneOrderScreen extends StatelessWidget {
  const DoneOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Conditional.single(


        conditionBuilder: (BuildContext context) => HomeCubit.get(context).listOrder.where((element) => element.orderState.toLowerCase() == 'New' ).isNotEmpty,
        widgetBuilder: (BuildContext context) {
          return ListView(
            children: const [
              Text('Done'),
            ],
          );
        },
        context: context,
        fallbackBuilder: (BuildContext context) => const Center(child: Text('No Orders')),
      ),
    );
  }
}
