import 'package:adopt_a_pet/ui/views/saved_pets/saved_pets.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;

  const CustomBottomNavigationBar({
    required this.currentPageIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        if (currentPageIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PetScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SavedPets()),
          );
        }
      },
      indicatorColor: Colors.deepPurple.withOpacity(0.5),
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
      ],
    );
  }
}
