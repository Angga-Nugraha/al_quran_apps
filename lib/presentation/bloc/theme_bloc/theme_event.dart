part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SetDarkEvent extends ThemeEvent {
  final bool value;
  const SetDarkEvent({required this.value});
  @override
  List<Object> get props => [value];
}

class GetDarkEvent extends ThemeEvent {}
