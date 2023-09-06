part of 'reminder_bloc.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object> get props => [];
}

class GetReminder extends ReminderEvent {}

class Remindered extends ReminderEvent {
  final bool value;
  const Remindered(this.value);

  @override
  List<Object> get props => [value];
}

class ReminderCancel extends ReminderEvent {
  final bool value;
  const ReminderCancel(this.value);

  @override
  List<Object> get props => [value];
}
