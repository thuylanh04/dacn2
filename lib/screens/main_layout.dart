import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_screen.dart';
import 'quick_analysis_screen.dart';
import 'transaction_screen.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;
  const MainLayout({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  Future<bool> _onWillPop() async {
    final nav = _navigatorKeys[_currentIndex].currentState;
    if (nav != null && nav.canPop()) {
      nav.pop();
      return false;
    }
    return true; // allow system back (may exit app on Android)
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildTabNavigator(_navigatorKeys[0], const HomeScreen()),
            _buildTabNavigator(_navigatorKeys[1], const QuickAnalysisScreen()),
            _buildTabNavigator(_navigatorKeys[2], const TransactionScreen()),
            _buildTabNavigator(_navigatorKeys[3], const CategoriesScreen()),
            _buildTabNavigator(_navigatorKeys[4], const ProfileScreen()),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildTabNavigator(GlobalKey<NavigatorState> key, Widget child) {
    return Navigator(
      key: key,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (_) => child),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE8F5F0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
        selectedItemColor: Color(0xFF14C996),
        unselectedItemColor: Color(0xFFBDBDBD),
      ),
    );
  }
}
