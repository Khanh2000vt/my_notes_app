import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/routing/routes.dart';

class BottomTabScreen extends StatefulWidget {
  final Widget child;
  const BottomTabScreen({super.key, required this.child});

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  int _selectedIndex = 0;

  static const List<String> _routes = [Routes.home, Routes.settings];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentPath = GoRouterState.of(context).uri.toString();
    final index = _routes.indexOf(currentPath);
    if (index != -1) {
      _selectedIndex = index;
    }
  }

  Theme bottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
