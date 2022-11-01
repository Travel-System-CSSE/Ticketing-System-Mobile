import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticketing_system/utils/colors.dart';
import 'package:ticketing_system/utils/global_variables.dart';

class RootNavigation extends StatefulWidget {
  const RootNavigation({super.key});

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        backgroundColor: Colors.white,
        activeColor: darkYellow,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? darkYellow : Colors.blueGrey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_rounded,
              color: _page == 1 ? darkYellow : Colors.blueGrey,
            ),
            label: 'Credits',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner_rounded,
              color: _page == 2 ? darkYellow : Colors.blueGrey,
            ),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.travel_explore_rounded,
              color: _page == 3 ? darkYellow : Colors.blueGrey,
            ),
            label: 'Travel History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _page == 4 ? darkYellow : Colors.blueGrey,
            ),
            label: 'Profile',
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
