// lib/app/widgets/generic_form_widget.dart
import 'package:flutter/material.dart';

class GenericFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<FormFieldConfig> fields;
  final VoidCallback onSubmit;
  final String submitButtonText;

  const GenericFormWidget({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.submitButtonText = 'Enviar',
  });

  @override
  _GenericFormWidgetState createState() => _GenericFormWidgetState();
}

class _GenericFormWidgetState extends State<GenericFormWidget> {
  Widget _buildFormField(FormFieldConfig field) {
    switch (field.type) {
      case FormFieldType.text:
        return TextFormField(
          controller: field.controller,
          decoration: InputDecoration(labelText: field.label),
          keyboardType: field.keyboardType,
          validator: field.validator as FormFieldValidator<dynamic>?,
          obscureText: field.obscureText ?? false,
        );
      case FormFieldType.dropdown:
        return DropdownButtonFormField<dynamic>(
          value: field.initialValue,
          decoration: InputDecoration(labelText: field.label),
          items: field.options
              ?.map((option) => DropdownMenuItem(
                    value: option.value,
                    child: Text(option.label),
                  ))
              .toList(),
          onChanged: field.onChanged,
          validator: field.validator as FormFieldValidator<dynamic>?,
        );
      case FormFieldType.switchField:
        return SwitchListTile(
          title: Text(field.label ?? ''),
          value: field.switchValue ?? false,
          onChanged: field.switchOnChanged,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Añade este Material como envolvente
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            ...widget.fields.map((field) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildFormField(field),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onSubmit,
              child: Text(widget.submitButtonText),
            ),
          ],
        ),
      ),
    );
  }
}

enum FormFieldType { text, dropdown, switchField }

class FormFieldConfig {
  final FormFieldType type;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final List<DropdownOption>? options;
  final dynamic initialValue;
  final Function(dynamic)? onChanged;
  final bool? switchValue;
  final Function(bool)? switchOnChanged;

  FormFieldConfig({
    required this.type,
    this.label,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText,
    this.options,
    this.initialValue,
    this.onChanged,
    this.switchValue,
    this.switchOnChanged,
    required String helperText,
  });
}

class DropdownOption {
  final dynamic value;
  final String label;

  DropdownOption({required this.value, required this.label});
}
