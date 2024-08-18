import 'dart:ui';

import '../../constants.dart';
import '../../data/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.characterModel});
  final CharacterModel characterModel;
  Widget _buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * .8,
      pinned: true,
      stretch: true,
      backgroundColor: kSecondaryColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          characterModel.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        background: Hero(
          tag: characterModel.id,
          child: Image.network(
            characterModel.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSecondaryColor,
        body: CustomScrollView(slivers: [
          _buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SliverListItem(
                        content: characterModel.name,
                        text: 'Name',
                      ),
                      SliverListItem(
                        content: characterModel.species,
                        text: 'Species',
                      ),
                      SliverListItem(
                        content: characterModel.status,
                        text: 'Status',
                      ),
                      SliverListItem(
                        content: characterModel.origin.name,
                        text: 'Origin',
                      ),
                      SliverListItem(
                        content: characterModel.gender,
                        text: 'Gender ',
                      ),
                      SliverListItem(
                        content: characterModel.species,
                        text: 'Species ',
                      ),
                      SliverListItem(
                        content: characterModel.location.name,
                        text: 'Location ',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 600,
                )
              ],
            ),
          )
        ]));
  }
}

class SliverListItem extends StatelessWidget {
  const SliverListItem({super.key, required this.content, required this.text});

  final String text, content;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: kPrimaryColor,
              width: 3,
            ),
          )),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '$text :',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            content,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
