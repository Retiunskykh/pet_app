import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_grid/pet_item.dart';
import 'package:flutter/material.dart';

class PetGrid extends StatelessWidget {
  final List<Pet> petList;
  final Function(Pet) onPetTap;
  final Function(Pet)? savePet;

  const PetGrid({
    super.key,
    required this.petList,
    required this.onPetTap,
    this.savePet,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.9,
      ),
      itemCount: petList.length,
      itemBuilder: (context, index) {
        return PetItem(
          pet: petList[index],
          onPetTap: onPetTap,
          savePet: savePet,
        );
      },
    );
  }
}
