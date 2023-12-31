import 'package:al_quran_apps/data/helpers/notification_helper.dart';
import 'package:al_quran_apps/injection.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/common/styles.dart';
import '../bloc/theme_bloc/theme_bloc.dart';
import 'home_page/home_page.dart';
import 'setting_page/settings_page.dart';
import 'profile_page/profile_page.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late NotificationHelper notificationHelper;
  int _bottomNavIndex = 1;
  bool isDarkTheme = false;
  List<Widget> _listWidget() => [
        SecondPage(),
        const HomePage(),
        const ProfilePage(),
      ];

  final List<TabItem> _tabData = [
    const TabItem(icon: Icons.settings_suggest_outlined, title: 'Settings'),
    const TabItem(icon: Icons.menu_book_outlined, title: 'Home'),
    const TabItem(icon: Icons.person_outline, title: 'Profile'),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    notificationHelper = locator<NotificationHelper>();

    notificationHelper.configureSelectNotificationSubject();
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = _listWidget();
    return Scaffold(
      body: listWidget[_bottomNavIndex],
      bottomNavigationBar: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is IsDarkTheme) {
            isDarkTheme = state.value;
          } else if (state is DarkThemeHasData) {
            isDarkTheme = state.value;
          } else if (state is DarkThemeHasError) {
            isDarkTheme = false;
          } else {
            isDarkTheme = false;
          }
          return ConvexAppBar(
            backgroundColor: isDarkTheme
                ? ThemeData.dark().colorScheme.surface
                : primaryColor,
            activeColor: onPrimary,
            style: TabStyle.reactCircle,
            curve: Curves.elasticIn,
            items: _tabData,
            initialActiveIndex: _bottomNavIndex,
            onTap: _onBottomNavTapped,
          );
        },
      ),
    );
  }
}
