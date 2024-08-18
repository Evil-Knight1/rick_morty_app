import '../../constants.dart';
import '../../data/models/character_model.dart';
import 'package:flutter/material.dart';

class CustomCharacterItem extends StatelessWidget {
  const CustomCharacterItem({super.key, required this.characterModel});
  final CharacterModel characterModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kThirdColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kThirdColor, width: 5),
      ),
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,
              arguments: characterModel);
        },
        child: GridTile(
          footer: Hero(
            tag: characterModel.id,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                characterModel.name,
                style: const TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                    color: kThirdColor,
                    fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: characterModel.image,
            // width: double.infinity,
            // height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
