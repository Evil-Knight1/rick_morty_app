import '../../constants.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.onChanged});
  final TextEditingController controller;
  final String hint;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            iconColor: Colors.black,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 18, color: kSecondaryColor)),
        style: const TextStyle(
          fontSize: 18,
          color: kSecondaryColor,
        ),
      ),
    );
  }
}
