import 'package:equatable/equatable.dart';

abstract class FormState extends Equatable {
  const FormState();

  @override
  List<Object> get props => [];
}

class FormInitial extends FormState {}

class FormLoading extends FormState {}

class FormSuccess extends FormState {}

class FormFailure extends FormState {
  final String errorMessage;

  const FormFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
