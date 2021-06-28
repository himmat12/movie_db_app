import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:movie_app/src/configs/configs.dart';

class FormWrapper extends StatelessWidget {
  const FormWrapper({
    Key? key,
    required this.formKey,
    this.absorbingPointerKey,
    this.formHeader,
    this.autovalidateMode,
    this.initialValue,
    this.onChanged,
    this.skipDisabled,
    this.enabled,
    this.absorbing,
    this.ignoringSemantics,
    this.formFields,
  }) : super(key: key);

  final Key formKey;
  final Key? absorbingPointerKey;
  final String? formHeader;
  final AutovalidateMode? autovalidateMode;
  final Map<String, dynamic>? initialValue;
  final void Function()? onChanged;
  final bool? skipDisabled;
  final bool? enabled;
  final bool? absorbing;
  final bool? ignoringSemantics;
  final List<Widget>? formFields;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing ?? false,
      ignoringSemantics: ignoringSemantics,
      key: absorbingPointerKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          formHeader == null
              ? const SizedBox.shrink()
              : Text(
                  formHeader ?? 'Form Header Text',
                  style: const TextStyle(
                    fontSize: l,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          const SizedBox(height: 12),
          FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: initialValue ?? {},
            onChanged: onChanged,
            skipDisabled: skipDisabled ?? false,
            enabled: enabled ?? true,
            child: Column(
              children: formFields ?? [],
            ),
          ),
        ],
      ),
    );
  }
}
