import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/helpers/notification_helper.dart';
import '../../bloc/reminder_bloc/reminder_bloc.dart';
import '../../bloc/theme_bloc/theme_bloc.dart';
import '../../widgets/components_helpers.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  final NotificationHelper notificationHelper = NotificationHelper();
  static bool? isScheduling;
  static bool? isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              "Settings",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: ListView(
              children: [
                BlocConsumer<ReminderBloc, ReminderState>(
                  listener: (context, state) {
                    if (state is ReminderedAlarm) {
                      mySnackbar(
                          context: context, message: 'Notification Activated');
                    }
                    if (state is CanceledAlarm) {
                      mySnackbar(
                          context: context,
                          message: 'Notification Deactivated');
                    }
                  },
                  builder: (context, state) {
                    if (state is IsReminder) {
                      isScheduling = state.value;
                    } else if (state is ReminderedAlarm) {
                      isScheduling = state.value;
                    } else if (state is CanceledAlarm) {
                      isScheduling = state.value;
                    }
                    return ListTile(
                      leading: const Icon(Icons.notifications_active_outlined),
                      title: const Text(
                        "Ingatkan Terakhir Baca",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Switch.adaptive(
                        value: isScheduling ?? false,
                        onChanged: (value) {
                          context.read<ReminderBloc>().add(Remindered(value));
                        },
                      ),
                    );
                  },
                ),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    if (state is IsDarkTheme) {
                      isDarkTheme = state.value;
                    } else if (state is DarkThemeHasData) {
                      isDarkTheme = state.value;
                    } else if (state is DarkThemeHasError) {
                      isDarkTheme = false;
                    }
                    return ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text(
                        "Mode Gelap",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Switch.adaptive(
                        value: isDarkTheme ?? false,
                        onChanged: (value) {
                          context
                              .read<ThemeBloc>()
                              .add(SetDarkEvent(value: value));
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const Text(
          '2023 \u00a9 Angga Nugraha \u{1f60e}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
