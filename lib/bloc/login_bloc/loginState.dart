// @dart=2.9
abstract class LoginState {}
class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {}
class LoginErorrState extends LoginState {
  String erorr ;
  LoginErorrState(this.erorr);
}

class ChangeInScreenState extends LoginState {}

