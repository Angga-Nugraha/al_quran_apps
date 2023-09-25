part of '../show_translate/show_tanslate_bloc.dart';

abstract class ShowTranslateEvent extends Equatable {
  const ShowTranslateEvent();

  @override
  List<Object> get props => [];
}

class ShowingEvent extends ShowTranslateEvent {
  final bool value;

  const ShowingEvent(this.value);
  @override
  List<Object> get props => [value];
}
