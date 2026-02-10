import 'package:flutter/material.dart';

/// Dropdown form field with validation support
class DropdownFormField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) getLabel;
  final ValueChanged<T?>? onChanged;
  final String? errorText;
  final String? hintText;

  const DropdownFormField({
    super.key,
    required this.label,
    required this.items,
    required this.getLabel,
    this.value,
    this.onChanged,
    this.errorText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<T>(
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            errorText: errorText,
          ),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(getLabel(item)),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
        ),
      ],
    );
  }
}
