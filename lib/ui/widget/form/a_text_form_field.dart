import 'package:flutter/material.dart';
import 'package:project_order_food/ui/shared/app_color.dart';

class ATextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? initValue;
  final int? maxLines;
  final String hintText;
  final String? Function(String?)? onSaved;
  final void Function(String)? onChanged;

  const ATextFormField(
      {super.key,
      this.validator,
      required this.label,
      this.keyboardType,
      this.maxLines=1,
      this.onChanged,
      this.initValue,
      this.obscureText = false,
      this.hintText = 'Enter new value',
      this.onSaved});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        onSaved: onSaved,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged:onChanged ,
        initialValue: initValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:
            validator ?? (v) => v!.isEmpty ? 'Không được để trống' : null,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          labelText: label,
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide(width: 1, color: AColor.black), //
          ),
         
          fillColor: AColor.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(width: 1, color: AColor.black), //
          ),
        ));
  }
}
