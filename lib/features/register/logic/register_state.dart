part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterErorr extends RegisterState {
  final String error;

  RegisterErorr({required this.error});
}

class IsIdFoundLoading extends RegisterState {}

class IsIdFoundSuccess extends RegisterState {}

class IsIdFoundError extends RegisterState {}
