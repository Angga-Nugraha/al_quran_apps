import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final List<String> tab;
  final TabController controller;
  const MyTabBar({
    required this.tab,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TabBar(
        isScrollable: true,
        controller: controller,
        tabs: List.generate(
          tab.length,
          (index) => Tab(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  tab[index],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
