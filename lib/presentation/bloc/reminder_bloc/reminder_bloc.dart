import 'package:al_quran_apps/domain/usecases/surah/get_reminder.dart';
import 'package:al_quran_apps/domain/usecases/surah/set_reminder_alarm.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final SetReminderAlarm setReminderAlarm;
  final GetReminderAlarm getReminderAlarm;
  ReminderBloc({
    required this.setReminderAlarm,
    required this.getReminderAlarm,
  }) : super(ReminderInitial()) {
    on<GetReminder>((event, emit) async {
      final result = await getReminderAlarm.execute();
      result.fold(
        (failure) => emit(ReminderedError(failure.message)),
        (data) => emit(IsReminder(data)),
      );
    });
    on<Remindered>((event, emit) async {
      final result = await setReminderAlarm.execute(event.value);

      result.fold(
        (failure) => emit(ReminderedError(failure.message)),
        (data) => emit(ReminderedAlarm(data)),
      );
    });
    on<ReminderCancel>((event, emit) async {
      final result = await setReminderAlarm.execute(event.value);

      result.fold(
        (failure) => emit(ReminderedError(failure.message)),
        (data) => emit(CanceledAlarm(data)),
      );
    });
  }
}
