import 'package:flutter/material.dart';
import 'package:hackathon/screens/bill_summary_screen.dart';
import 'package:hackathon/screens/home_screen.dart';
import 'package:hackathon/screens/profile_screen.dart';
import 'package:hackathon/screens/scan_screen.dart';
import '../presentation/providers/main_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainProvider.addListener(updateScreen);
    });
  }

  @override
  void dispose() {
    mainProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: mainProvider.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          ScanScreen(),
          BillSummaryScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.1)),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              onTap: mainProvider.changeTabIndex,
              currentIndex: mainProvider.currentTabIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              selectedIconTheme: IconThemeData(size: 28, color: Colors.black),
              unselectedIconTheme: IconThemeData(size: 28),
              selectedLabelStyle: TextStyle(
                  fontFamily: 'NotoSansKR', fontSize: 12, height: 1.5),
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'NotoSansKR', fontSize: 12, height: 1.5),
              items: [
                _buildBottomNavBarItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: '홈',
                ),
                _buildBottomNavBarItem(
                  icon: Icons.document_scanner_outlined,
                  activeIcon: Icons.document_scanner,
                  label: '스캔',
                ),
                _buildBottomNavBarItem(
                  icon: Icons.short_text,
                  activeIcon: Icons.short_text_outlined,
                  label: '청구서요약',
                ),
                _buildBottomNavBarItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: '프로필',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) =>
      BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Icon(icon),
          ],
        ),
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Icon(activeIcon, color: Colors.black),
          ],
        ),
        label: label,
      );
}
