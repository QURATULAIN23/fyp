import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final Widget? icon;
  final int? maxLines;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String? preText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final Function()? onTap;
  const InputField({Key? key, this.hintText, this.labelText, this.keyboardType, this.validator, this.controller, this.maxLength, this.icon, this.maxLines, this.readOnly, this.suffixIcon, this.prefix, this.onChanged, this.preText, this.inputFormatters, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child:  TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        maxLines: maxLines ?? 1,
        readOnly: readOnly ?? false,
        autovalidateMode: AutovalidateMode.disabled,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            hintText: hintText,
            labelText: labelText,
            icon: icon,
            prefixIcon: prefix,
            suffixIcon: suffixIcon,
            prefixText: preText,
            fillColor: Colors.grey[500],
            border: InputBorder.none
        ),
      ),
    );
  }
}
