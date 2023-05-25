import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/page_header_text.dart';
import 'package:transport/widgets/tail_type/tail_type_item_view.dart';

import '../../blocs/cargo_type_bloc.dart';
import '../../blocs/tail_type_bloc.dart';
import '../../models/cargo_type.dart';
import '../../models/tail_type.dart';
import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class TailTypeListView extends StatelessWidget {
  List<TailType> types = [];
  TailTypeListView(this.types);

  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void createCargoType() {
      if (formKey.currentState!.validate()) {
        try {
          var name = nameController.text;
          var type = new TailType(0, name);
          var bloc = context.read<TailTypeBloc>();
          bloc.add(CreateTailTypeEvent(type));
          bloc.add(InitialTailTypeEvent());
        } catch (error) {
          var errorMessage = error.toString();
          showDialog(
              context: context,
              builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
          );
        }
      }
    }
    return Column(
      children: [
        PageHeaderText(text: "Типы борта"),
        SizedBox(height: 10,),
        ListView(
          shrinkWrap: true,
          children: types.map((e) => TailTypeItemView(e)).toList(),
        ),
        Form(
          key: formKey,
          child: Container(
              child: CustomTextField(
                controller: nameController,
                hint: 'Название',
                type: FieldType.text,
                validator: (val) {
                  if(val!.isEmpty){
                    return 'Введите значение!';
                  }
                },
              )
          ),
        ),
        CustomButton(btnText: "Добавить", onTap: createCargoType, btnColor: Colors.green),
      ],
    );
  }
}
