import 'package:flutter/material.dart';
import 'package:recepies_io/screens/tabs/home_tab.dart';
import 'package:recepies_io/screens/tabs/meals_tab.dart';
import 'package:recepies_io/screens/tabs/favorites_tab.dart';
import 'package:recepies_io/screens/tabs/profile_tab.dart';

class MainShell extends StatefulWidget {
  final String nama;
  final String nim;

  const MainShell({
    super.key,
    required this.nama,
    required this.nim,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeTab(),
      MealsTab(),
      FavoritesTab(),
      ProfileTab(nama: widget.nama, nim: widget.nim,),
    ];

    return LayoutBuilder(                          
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Scaffold(
            body: pages[_currentIndex],            
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
              destinations: _destinations, 
            ),
          );
        }
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() => _currentIndex = index);
                },
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.fastfood_outlined),
                    selectedIcon: Icon(Icons.fastfood),
                    label: Text('Meals'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite_border),
                    selectedIcon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: pages[_currentIndex]),  
            ],
          ),
        );
      },
    );
  }

  static const List<NavigationDestination> _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.fastfood_outlined),
      selectedIcon: Icon(Icons.fastfood),
      label: 'Meals',
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_border),
      selectedIcon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
}


