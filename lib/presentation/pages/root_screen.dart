import 'package:al_quran_apps/common/colors.dart';
import 'package:al_quran_apps/common/routes.dart';
import 'package:al_quran_apps/data/helpers/notification_helper.dart';
import 'package:al_quran_apps/injection.dart';
import 'package:al_quran_apps/presentation/pages/home_page.dart';
import 'package:al_quran_apps/presentation/pages/second_page.dart';
import 'package:al_quran_apps/presentation/pages/third_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late NotificationHelper notificationHelper;
  int _bottomNavIndex = 1;
  List<Widget> _listWidget() => [
        SecondPage(),
        const HomePage(),
        const ThirdPage(),
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

    notificationHelper.configureSelectNotificationSubject(detailPageRoutes);
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
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: kOxfordBlue,
        activeColor: darkColor,
        style: TabStyle.reactCircle,
        items: _tabData,
        initialActiveIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
