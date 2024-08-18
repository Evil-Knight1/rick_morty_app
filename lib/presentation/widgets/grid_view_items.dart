import '../../data/models/character_model.dart';
import 'custom_character_item.dart';
import 'package:flutter/material.dart';

class GridViewItems extends StatelessWidget {
  const GridViewItems({
    super.key,
    required this.characterList,
  });

  final List<CharacterModel> characterList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        itemCount: characterList.length,
        itemBuilder: (context, index) => CustomCharacterItem(
              characterModel: characterList[index],
            ));
  }
}
