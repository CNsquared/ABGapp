import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Entry form that take in tip and stores in [NormalSplitState] state
class EntryForm extends StatelessWidget {
  final TextEditingController controller;
  final String prompt;
  final Icon icon;
  late final FilteringTextInputFormatter inputFormatter;
  late final TextInputType keyboardType;

  EntryForm({
    super.key,
    required this.controller,
    required this.prompt,
    Icon? icon,
    String? filter,
  }) : icon = icon ?? Icon(Icons.face_2_sharp) {
    switch (filter) {
      case "name":
        inputFormatter = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"));
        keyboardType = TextInputType.name;
        break;
      case "money":
        inputFormatter =
            FilteringTextInputFormatter.allow(RegExp(r'(\d+)?\.?\d{0,2}'));
        keyboardType = const TextInputType.numberWithOptions(decimal: true);
        break;
      case "integer":
      default:
        inputFormatter = FilteringTextInputFormatter.allow(RegExp(r"[0-9]"));
        keyboardType = const TextInputType.numberWithOptions(decimal: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Card(
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            labelText: prompt,
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5),
              child: icon,
            ),
          ),
          keyboardType: keyboardType,
          inputFormatters: [
            inputFormatter,
          ],
        ),
      ),
    );
  }
}
