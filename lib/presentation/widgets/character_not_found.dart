import 'package:flutter/material.dart';

class CharacterNotFound extends StatelessWidget {
  const CharacterNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'No Characters Found',
          style: TextStyle(color: Colors.redAccent, fontSize: 32),
        ),
      );
  }
}
