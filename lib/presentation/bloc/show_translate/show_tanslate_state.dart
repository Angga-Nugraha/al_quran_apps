part of '../show_translate/show_tanslate_bloc.dart';

abstract class ShowTranslateState extends Equatable {
  const ShowTranslateState();

  @override
  List<Object> get props => [];
}

class ShowTanslateInitial extends ShowTranslateState {}

class ShowingState extends ShowTranslateState {
  final bool result;

  const ShowingState(this.result);
  @override
  List<Object> get props => [result];
}

class HiddenState extends ShowTranslateState {
  final bool result;

  const HiddenState(this.result);
  @override
  List<Object> get props => [result];
}
