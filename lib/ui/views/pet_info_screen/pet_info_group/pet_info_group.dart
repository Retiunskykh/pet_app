import 'package:adopt_a_pet/ui/views/pet_info_screen/pet_info_group/pet_info_group_item.dart';
import 'package:flutter/material.dart';

class PetInfoGroup extends StatelessWidget {
  final String gender;
  final String age;
  final String size;
  final String? breed;

  const PetInfoGroup({
    super.key,
    required this.gender,
    required this.age,
    required this.size,
    required this.breed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PetInfoGroupItem(
          value: gender,
          label: "Gender",
        ),
        PetInfoGroupItem(
          value: age,
          label: "Age",
        ),
        PetInfoGroupItem(
          value: size,
          label: "Size",
        ),
        PetInfoGroupItem(
          value: breed ?? "Unknown",
          label: "Breed",
        ),
      ],
    );
  }
}
