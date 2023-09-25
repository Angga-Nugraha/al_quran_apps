part of '../show_translate/show_tanslate_bloc.dart';

abstract class ShowTranslateState extends Equatable {
  const ShowTranslateState();

  @override
  List<Object> get props => [];
}

class ShowTranslateInitial extends ShowTranslateState {
  final bool result;

  const ShowTranslateInitial({this.result = true});
  @override
  List<Object> get props => [result];
}

class ShowingState extends ShowTranslateState {
  final bool result;

  const ShowingState(this.result);
  @override
  List<Object> get props => [result];
}
