import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../configs/configs.dart';

class FormFieldsWidget extends StatefulWidget {
  const FormFieldsWidget({
    Key? key,
    this.name,
    this.hintText,
    this.labelText,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.obscureField = false,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.initialValue,
    this.readOnly,
    this.border,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.errorBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.focusColor,
    this.fillColor,
  }) : super(key: key);

  final String? name;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final bool? obscureField;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final String? initialValue;
  final bool? readOnly;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final Color? focusColor;
  final Color? fillColor;

  @override
  State<FormFieldsWidget> createState() => _FormFieldsWidgetState();
}

class _FormFieldsWidgetState extends State<FormFieldsWidget> {
  bool _obsecureText = false;

  @override
  void initState() {
    super.initState();
    _obsecureText = widget.obscureField == true ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  widget.labelText ?? 'label text',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: n - 2, color: Colors.blueGrey.shade600),
                ),
              ),
        FormBuilderTextField(
          name: widget.name ?? '',
          initialValue: widget.initialValue,
          validator: widget.validator ??
              (data) {
                FormBuilderValidators.required(context, errorText: data);
                return null;
              },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLengthEnforcement:
              MaxLengthEnforcement.truncateAfterCompositionEnds,
          maxLines: widget.maxLines ?? 1,
          obscureText: _obsecureText,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          readOnly: widget.readOnly ?? false,
          cursorColor: Colors.green.shade300,
          style: const TextStyle(
            fontSize: n,
            color: secondaryDarkBlue,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText ?? '',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            filled: true,
            fillColor: widget.fillColor ?? const Color(0xff3d5661),
            focusColor: widget.focusColor ?? Colors.green.shade200,
            suffixIcon: widget.obscureField == false
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _obsecureText = !_obsecureText;
                      });
                    },
                    icon: Icon(
                      _obsecureText == false
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      // color: textColor,
                      size: 18,
                    )),
            border: widget.border ?? InputBorder.none,
            focusedBorder: widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade300),
                  borderRadius: BorderRadius.circular(4),
                  gapPadding: 0,
                ),
            focusedErrorBorder: widget.focusedErrorBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                  borderRadius: BorderRadius.circular(4),
                  gapPadding: 0,
                ),
            errorBorder: widget.errorBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                  borderRadius: BorderRadius.circular(4),
                  gapPadding: 0,
                ),
            enabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                  gapPadding: 0,
                ),
            disabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                  gapPadding: 0,
                ),
          ),
        ),
      ],
    );
  }
}
