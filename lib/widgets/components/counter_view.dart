import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  final int initCount;
  final Function countCallback;
  CounterView({required this.initCount, required this.countCallback});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _currentCount;
  late Function _counterCallback;
  @override
  void initState() {
    _counterCallback = widget.countCallback;
    _currentCount = widget.initCount ?? 1;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createIncrementDicrementButton(Icons.remove, () => _dicrement()),
          SizedBox(width: 20,child: Center(child: Text(_currentCount.toString()))),
          _createIncrementDicrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    _currentCount++;
    _counterCallback(_currentCount);
  }

  void _dicrement() {
    if (_currentCount > 0) {
      _currentCount--;
      _counterCallback(_currentCount);
    }
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: () => onPressed(),
      elevation: 2.0,
      fillColor: Colors.grey[300],
      child: Icon(
        icon,
        color: Colors.black,
        size: 12.0,
      ),
      shape: CircleBorder(),
    );
  }
}
