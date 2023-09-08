part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class IsDarkTheme extends ThemeState {
  final bool value;
  const IsDarkTheme({required this.value});
  @override
  List<Object> get props => [value];
}

class DarkThemeHasData extends ThemeState {
  final bool value;
  const DarkThemeHasData({required this.value});
  @override
  List<Object> get props => [value];
}

class DarkThemeHasError extends ThemeState {
  final String message;
  const DarkThemeHasError({required this.message});
  @override
  List<Object> get props => [message];
}
