import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormWrapper extends StatelessWidget {
  const FormWrapper({
    required this.formKey,
    Key? key,
    this.autovalidateMode,
    this.initialValue,
    this.onChanged,
    this.skipDisabled,
    this.enabled,
    this.formFields,
  }) : super(key: key);

  final Key formKey;
  final AutovalidateMode? autovalidateMode;
  final Map<String, dynamic>? initialValue;
  final void Function()? onChanged;
  final bool? skipDisabled;
  final bool? enabled;
  final List<Widget>? formFields;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      initialValue: initialValue ?? {},
      onChanged: onChanged,
      skipDisabled: skipDisabled ?? false,
      enabled: enabled ?? true,
      child: Column(
        children: formFields ?? [],
      ),
    );
  }
}
