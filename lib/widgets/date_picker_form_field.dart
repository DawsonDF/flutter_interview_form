import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Date picker form field for date of birth
class DatePickerFormField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final String? errorText;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePickerFormField({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
    this.errorText,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM/dd/yyyy');
    final displayText = value != null ? dateFormat.format(value!) : '';

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: 'MM/DD/YYYY',
        errorText: errorText,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      controller: TextEditingController(text: displayText),
      onTap: () async {
        final now = DateTime.now();
        final initialDate = value ?? DateTime(now.year - 25, now.month, now.day);
        
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? now,
          helpText: 'Select Date of Birth',
        );

        if (selectedDate != null && onChanged != null) {
          onChanged!(selectedDate);
        }
      },
    );
  }
}
