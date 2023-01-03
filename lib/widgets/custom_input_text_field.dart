import 'package:flutter/material.dart';

class CustomInputTextField extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextCapitalization? textCapitalization;
  final String formProperty;
  final Map<String, String> formValues;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;

  const CustomInputTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
    this.textCapitalization,
    this.validator,
    this.controller,
    this.maxLines, 
    this.minLines,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          border: Border.all(color: Colors.black,),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: TextFormFieldMod(
            
            keyboardType: keyboardType, 
            formValues: formValues, 
            formProperty: formProperty, 
            obscureText: obscureText, 
            hintText: hintText, 
            labelText: labelText, 
            helperText: helperText, 
            suffixIcon: suffixIcon, 
            icon: icon,
            textCapitalization: textCapitalization,
            controller: controller,
            validator: validator,
            maxLines: maxLines,
            minLines: minLines,
          ),
        ),
      ),
    );
  }
}


class TextFormFieldMod extends StatelessWidget {
  const TextFormFieldMod({
    Key? key,
    required this.keyboardType,
    required this.formValues,
    required this.formProperty,
    required this.obscureText,
    required this.hintText,
    required this.labelText,
    required this.helperText,
    required this.suffixIcon,
    required this.icon,
    this.textCapitalization, 
    this.validator, 
    this.controller,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final Map<String, String> formValues;
  final String formProperty;
  final bool? obscureText;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? suffixIcon;
  final IconData? icon;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autofocus: false,
      textCapitalization: textCapitalization == null ? TextCapitalization.none : textCapitalization!,
      keyboardType: keyboardType,
      onChanged: (value) {
        formValues[formProperty] = value;
      },
      validator: validator == null ? null : validator!,
      controller: controller,
      obscureText: obscureText == null ? false : true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        border: InputBorder.none,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        icon: icon == null ? null : Icon(icon),
      ),
    );
  }
}