import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom text form field with built-in validation display
///
/// Features:
/// - Shows error message below field
/// - Shows loading indicator during async validation
/// - Customizable input formatters and keyboard type
class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? value;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final String? errorText;
  final bool isValidating;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool readOnly;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.hintText,
    this.value,
    this.onChanged,
    this.onEditingComplete,
    this.errorText,
    this.isValidating = false,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          initialValue: controller == null ? value : null,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            errorText: errorText,
            suffixIcon: isValidating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : errorText != null
                    ? const Icon(Icons.error_outline, color: Colors.red)
                    : null,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          readOnly: readOnly,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }
}

/// Phone number input formatter (US format)
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final buffer = StringBuffer();

    if (text.length >= 1) {
      buffer.write('(${text.substring(0, text.length.clamp(0, 3))}');
    }
    if (text.length >= 4) {
      buffer.write(') ${text.substring(3, text.length.clamp(3, 6))}');
    }
    if (text.length >= 7) {
      buffer.write('-${text.substring(6, text.length.clamp(6, 10))}');
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
