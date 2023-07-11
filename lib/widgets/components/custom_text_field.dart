import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transport/helpers/input_formatters_helper.dart';

enum FieldType {text, password, num}

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
  late String _hint;
  late TextEditingController _controller;
  late FieldType _type;
  late String? Function(String?)? _validator;
  @override
  void initState() {
    this._hint = widget.hint;
    this._controller = widget.controller;
    this._type = widget.type;
    this._validator = widget.validator;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: _type == FieldType.num ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
        controller: _controller,
        validator: _validator,
        obscureText: _type == FieldType.password? !_obscure : _obscure,
        decoration: InputDecoration(
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            labelText: _hint,
            alignLabelWithHint: true,
            labelStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: _type == FieldType.password? IconButton(
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                }) : null
            ),
        inputFormatters: _type == FieldType.num ? numFormatter() : null,
      ),
    );

  }
}


