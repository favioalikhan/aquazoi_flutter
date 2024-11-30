// lib/app/widgets/generic_entity_form_view.dart
import 'package:flutter/material.dart';

import 'generic_form_widget.dart';

class GenericEntityFormView extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final List<FormFieldConfig> fields;
  final VoidCallback onSubmit;
  final String submitButtonText;

  const GenericEntityFormView({
    super.key,
    required this.title,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.submitButtonText = 'Enviar',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: GenericFormWidget(
          formKey: formKey,
          fields: fields,
          onSubmit: onSubmit,
          submitButtonText: submitButtonText,
        ),
      ),
    );
  }
}
