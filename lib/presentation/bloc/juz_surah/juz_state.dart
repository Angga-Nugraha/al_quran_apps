part of 'juz_bloc.dart';

abstract class JuzState extends Equatable {
  const JuzState();

  @override
  List<Object> get props => [];
}

class JuzInitial extends JuzState {}

class JuzLoading extends JuzState {}

class JuzLoaded extends JuzState {
  final Juz result;

  const JuzLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class JuzError extends JuzState {
  final String message;

  const JuzError({required this.message});

  @override
  List<Object> get props => [message];
}
