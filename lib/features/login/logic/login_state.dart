part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginErorr extends LoginState {
  final String error;

  LoginErorr({required this.error});
}

final class GetDataErorrState extends LoginState {
  final String error;

  GetDataErorrState({required this.error});
}

final class UpdateLoading extends LoginState {}

final class UpdateSuccess extends LoginState {}

final class UpdateErorr extends LoginState {
  final String error;

  UpdateErorr({required this.error});
}

final class SignedIn extends LoginState {
  final String error;

  SignedIn({required this.error});
}

final class NotSignedIn extends LoginState {}

final class SignedInLoading extends LoginState {}
