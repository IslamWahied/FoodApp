// @dart=2.9
abstract class RegisterState {}
class RegisterInitState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorState extends RegisterState {
  String error ;
  RegisterErrorState(this.error);
}

class RegisterChangeInScreenState extends RegisterState {}
class Refersh extends RegisterState {}