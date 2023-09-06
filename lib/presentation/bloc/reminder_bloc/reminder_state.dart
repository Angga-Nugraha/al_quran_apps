part of 'reminder_bloc.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

class ReminderInitial extends ReminderState {}

class IsReminder extends ReminderState {
  final bool value;
  const IsReminder(this.value);

  @override
  List<Object> get props => [value];
}

class ReminderedAlarm extends ReminderState {
  final bool value;
  const ReminderedAlarm(this.value);

  @override
  List<Object> get props => [value];
}

class ReminderedError extends ReminderState {
  final String message;
  const ReminderedError(this.message);

  @override
  List<Object> get props => [message];
}

class CanceledAlarm extends ReminderState {
  final bool value;
  const CanceledAlarm(this.value);

  @override
  List<Object> get props => [value];
}
