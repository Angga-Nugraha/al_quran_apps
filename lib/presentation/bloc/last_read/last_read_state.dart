part of 'last_read_bloc.dart';

abstract class LastReadState extends Equatable {
  const LastReadState();

  @override
  List<Object> get props => [];
}

class LastReadInitial extends LastReadState {}

class LastReadHasData extends LastReadState {
  final Map<String, dynamic> result;
  const LastReadHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class LastReadHasSuccess extends LastReadState {
  final String result;
  const LastReadHasSuccess({required this.result});

  @override
  List<Object> get props => [result];
}

class LastReadHasError extends LastReadState {
  final String message;
  const LastReadHasError({required this.message});

  @override
  List<Object> get props => [message];
}
