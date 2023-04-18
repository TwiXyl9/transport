import 'package:flutter/material.dart';

enum FieldType {text,password}

class CustomTextField extends StatefulWidget {
  final String hint;
  final controller;
  final FieldType type;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.type,
    required this.validator
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();

}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.type == FieldType.password? !_obscure : _obscure,
      decoration: InputDecoration(
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          labelText: widget.hint,
          labelStyle: TextStyle(color: Colors.grey[500]),
          suffixIcon: widget.type == FieldType.password? IconButton(
              icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              }) : null
          ),


      );

  }
}


