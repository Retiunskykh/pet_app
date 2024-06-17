import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/ui/widgets/text/label2_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PetItem extends StatelessWidget {
  final Pet pet;
  final Function(Pet) onPetTap;
  final Function(Pet)? savePet;

  const PetItem({
    super.key,
    required this.pet,
    required this.onPetTap,
    this.savePet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPetTap(pet),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  pet.primaryPhotoCropped?.small == null
                      ? Container(
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: Color(0x805F5B5B),
                            size: 48.0,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          child: Image.network(
                            pet.primaryPhotoCropped!.small,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                  savePet != null ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                    child: GestureDetector(
                      onTap: () => savePet!(pet),
                      child: const Icon(Icons.favorite, color: Colors.deepPurple, size: 28),
                    ),
                  ) : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 16.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Label2Text(
                      text: pet.name,
                      textColor: const Color(0xFF5F5B5B),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/vectors/${pet.gender == "Male" ? 'ic_male.svg' : 'ic_female.svg'}',
                    height: 22.0,
                    width: 22.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
