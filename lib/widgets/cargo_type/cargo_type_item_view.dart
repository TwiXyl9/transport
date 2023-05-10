import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/models/car.dart';

import '../../blocs/cargo_type_bloc.dart';
import '../../models/cargo_type.dart';

class CargoTypeItemView extends StatefulWidget {
  CargoType type;
  CargoTypeItemView(this.type);

  @override
  State<CargoTypeItemView> createState() => _CargoTypeItemViewState();
}

class _CargoTypeItemViewState extends State<CargoTypeItemView> {
  bool isEditable = false;
  late CargoType _type;
  @override
  void initState() {
    _type = widget.type;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CargoTypeBloc>(context, listen: false);
    TextEditingController nameController = TextEditingController(text: _type.name);
    final formKey = GlobalKey<FormState>();

    void editType(){
      setState(() {
        isEditable = !isEditable;
      });
    }
    void deleteType(){
      bloc.add(DeleteCargoTypeEvent(_type));
      bloc.add(InitialCargoTypeEvent());
    }
    void doneEdit(){
      if (formKey.currentState!.validate()) {
        _type.name = nameController.text;
        bloc.add(UpdateCargoTypeEvent(_type));
        bloc.add(InitialCargoTypeEvent());
        setState(() {
          isEditable = !isEditable;
        });
      }

    }
    void canselEdit(){
      setState(() {
        isEditable = !isEditable;
      });
    }
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: isEditable?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Container(
                width: 150,
                  child: TextFormField(
                    controller: nameController,
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'Введите значение!';
                      }
                    },
                  )
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: doneEdit,
                    icon: Icon(Icons.done)
                ),
                SizedBox(width: 10,),
                IconButton(
                    onPressed: canselEdit,
                    icon: Icon(Icons.close)
                )
              ],
            ),
          ],
        ) :
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_type.name),
            Row(
              children: [
                IconButton(
                    onPressed: editType,
                    icon: Icon(Icons.edit)
                ),
                SizedBox(width: 10,),
                IconButton(
                    onPressed: deleteType,
                    icon: Icon(Icons.delete)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
