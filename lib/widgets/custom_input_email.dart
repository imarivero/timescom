import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/register_form_provider.dart';
import 'package:timescom/screens/registro_alumno.dart';

class CustomInputTextFieldemail extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String formProperty;
  final Map<String, String> formValues;

  const CustomInputTextFieldemail({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
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
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15)),
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
              icon: icon),
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

  @override
  Widget build(BuildContext context) {
    final registroForm = Provider.of<RegisterFormProvider>(context);

    return TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType,
      onChanged: (value) => registroForm.email = value,
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);

        return regExp.hasMatch(value ?? '')
            ? null
            : 'El valor ingresado no luce como un correo';
      },
      obscureText: obscureText == null ? false : true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
