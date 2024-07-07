import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class form_container_widget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  const form_container_widget(
      {super.key,
      this.controller,
      this.fieldKey,
      this.isPasswordField,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType});

  @override
  State<form_container_widget> createState() => _form_container_widgetState();
}

class _form_container_widgetState extends State<form_container_widget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      controller: widget.controller,
      keyboardType: widget.inputType,
      key: widget.fieldKey,
      obscureText: widget.isPasswordField == true ? _obscureText : false,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white, width: 2.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white, width: 1),
        ),
        hintText: widget.hintText,
        hintStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: widget.isPasswordField == true
              ? Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: _obscureText == false ? Colors.white : Colors.white70,
                )
              : const Text(""),
        ),
      ),
    );
  }
}
