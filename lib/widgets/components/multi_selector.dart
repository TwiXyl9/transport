import 'package:flutter/material.dart';
import 'package:transport/widgets/components/counter_view.dart';

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final int value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  final List<MultiSelectDialogItem<V>> items;
  final Map<int,int> initialSelectedValues;
  MultiSelectDialog(this.items, this.initialSelectedValues);



  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Map<int,int>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(Map<int,int> itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.addAll(itemValue);
      } else {
        _selectedValues.remove(itemValue.keys.toList().first);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Выберите услуги'),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        TextButton(
          child: Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.keys.contains(item.value);
    int count = checked? _selectedValues[item.value]! : 1;
    setCountCallback(val) {
      setState(() {
        count = val;
        _selectedValues[item.value] = count;
      });
    }
    return CheckboxListTile(
      value: checked,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.label),
          checked? CounterView(initCount: count, countCallback: setCountCallback,): Container()
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange({item.value : count}, checked!),
    );
  }

}
