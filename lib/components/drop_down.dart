import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final Function(String) onChanged;
  final String labelText;

  CustomDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownButtonFormField(
        value: widget.value,
        items: widget.items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          widget.onChanged(newValue!);
        },
        icon: const Icon(Icons.arrow_drop_down_circle,
            color: Color.fromARGB(255, 141, 122, 16)),
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
