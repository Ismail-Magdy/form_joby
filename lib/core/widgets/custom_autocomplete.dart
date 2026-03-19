import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CustomAutocomplete extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> options;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CustomAutocomplete({
    super.key,
    required this.label,
    required this.hint,
    required this.options,
    required this.controller,
    this.prefixIcon,
    this.validator,
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
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return options;
            }
            return options.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            controller.text = selection;
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            // We need to keep our external controller in sync and initialize field with its content
            if (controller.text.isNotEmpty && fieldTextEditingController.text.isEmpty) {
              fieldTextEditingController.text = controller.text;
            }
            // Listen to the internal controller to update the external one
            fieldTextEditingController.addListener(() {
              if (controller.text != fieldTextEditingController.text) {
                controller.text = fieldTextEditingController.text;
              }
            });

            return TextFormField(
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              validator: validator,
              cursorColor: AppTheme.primaryBlue,
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: prefixIcon,
                suffixIcon: const Icon(Icons.arrow_drop_down, color: AppTheme.textLight),
              ),
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300), // Adjust width logic in parent if possible
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(option),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
