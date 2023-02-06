import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
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

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
      ),

      // actions: [
      //   IconButton(
      //     onPressed: () => navigationTapped(0),
      //     icon: const Icon(
      //       Icons.home,
      //     ),
      //     color: _page == 0 ? primaryColor : secondaryColor,
      //   ),
      //   IconButton(
      //     onPressed: () => navigationTapped(1),
      //     icon: const Icon(
      //       Icons.search,
      //     ),
      //     color: _page == 1 ? primaryColor : secondaryColor,
      //   ),
      //   IconButton(
      //     onPressed: () => navigationTapped(2),
      //     icon: const Icon(
      //       Icons.add_a_photo,
      //     ),
      //     color: _page == 2 ? primaryColor : secondaryColor,
      //   ),
      //   IconButton(
      //     onPressed: () => navigationTapped(3),
      //     icon: const Icon(
      //       Icons.favorite,
      //     ),
      //     color: _page == 3 ? primaryColor : secondaryColor,
      //   ),
      //   IconButton(
      //     onPressed: () => navigationTapped(4),
      //     icon: const Icon(
      //       Icons.person,
      //     ),
      //     color: _page == 4 ? primaryColor : secondaryColor,
      //   ),
      // ],
    );
  }
}
