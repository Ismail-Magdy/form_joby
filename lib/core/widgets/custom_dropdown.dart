import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textDark,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: onChanged,
          validator: validator,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.textLight),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
