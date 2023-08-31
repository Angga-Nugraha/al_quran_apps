part of 'last_read_bloc.dart';

abstract class LastReadEvent extends Equatable {
  const LastReadEvent();

  @override
  List<Object> get props => [];
}

class InsertLastReadEvent extends LastReadEvent {
  final Map<String, dynamic> surah;
  const InsertLastReadEvent({required this.surah});

  @override
  List<Object> get props => [surah];
}

class GetLastReadEvent extends LastReadEvent {}
