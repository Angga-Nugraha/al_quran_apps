import 'package:al_quran_apps/data/helpers/notification_helper.dart';
import 'package:al_quran_apps/injection.dart';
import 'package:al_quran_apps/presentation/bloc/reminder_bloc/reminder_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  final NotificationHelper notificationHelper = NotificationHelper();
  static bool? isScheduling;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ReminderBloc>()..add(GetReminder()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings apps",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: ListTile(
            title: const Text("Reminder me"),
            trailing: BlocBuilder<ReminderBloc, ReminderState>(
              builder: (context, state) {
                if (state is IsReminder) {
                  isScheduling = state.value;
                } else if (state is ReminderedAlarm) {
                  isScheduling = state.value;
                } else if (state is CanceledAlarm) {
                  isScheduling = state.value;
                }
                return Switch.adaptive(
                  value: isScheduling ?? false,
                  onChanged: (value) {
                    if (!value) {
                      context.read<ReminderBloc>().add(Remindered(value));
                    } else {
                      context.read<ReminderBloc>().add(ReminderCancel(value));
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
