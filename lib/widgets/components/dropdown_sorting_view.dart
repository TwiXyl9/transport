import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownSortingView extends StatefulWidget {
  final Function callback;
  final String value;

  DropdownSortingView(this.callback, this.value);

  @override
  _DropdownSortingViewState createState() => _DropdownSortingViewState();
}

class _DropdownSortingViewState extends State<DropdownSortingView> {
  final FocusNode _focusNode = FocusNode();

  List<String> sortBy = ['По дате выполнения', 'По новизне', 'По цене'];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: widget.value,
        isExpanded: true,
        items: getItems(),
        onChanged: (val) {
          widget.callback(val);
          _focusNode.unfocus();
        },
        focusNode: _focusNode,
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.white,
          ),
          elevation: 2,
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getItems() {
    return sortBy.map((type) {
      return DropdownMenuItem(
        child: Text(type),
        value: type,
      );
    }).toList();
  }
}