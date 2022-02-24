// @dart=2.9
import 'package:flutter_bloc/flutter_bloc.dart';

import 'OrderState.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitState());

  static OrderCubit get(context) => BlocProvider.of(context);


int sugerIndex = 0;

}