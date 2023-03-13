import 'package:flutter/material.dart';

class BottomNavigationAndDarkMode extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const BottomNavigationAndDarkMode({
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Lista Avaliações',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Registo Avaliação',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: onIndexChanged,
    );
  }
}
