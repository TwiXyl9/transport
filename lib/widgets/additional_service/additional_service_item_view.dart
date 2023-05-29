import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/widgets/additional_service/additional_service_dialog.dart';

import '../../blocs/additional_service_bloc.dart';
import '../../models/service.dart';
import '../../models/user.dart';

class AdditionalServiceItemView extends StatelessWidget {
  Service service;
  User user;
  AdditionalServiceItemView(this.service, this.user);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AdditionalServiceBloc>(context, listen: false);

    void editType(){
        showDialog(
            context: context,
            builder: (BuildContext context) {
          return AdditionalServiceDialog(service);
        }
      );
    }

    void deleteType(){
      bloc.add(DeleteAdditionalServiceEvent(service));
      bloc.add(InitialAdditionalServiceEvent());
    }

    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Image.network(service.imageUrl, height: 100, fit: BoxFit.scaleDown,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.name),
                    Text(service.description, softWrap: true,),
                    Text('${service.price} б.р.')
                  ],
                ),
              ],
            ),
            user.isAdmin()?
            Row(
              children: [
                Expanded(
                  child: IconButton(
                      onPressed: editType,
                      icon: Icon(Icons.edit)
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: IconButton(
                      onPressed: deleteType,
                      icon: Icon(Icons.delete)
                  ),
                )
              ],
            ) :
            Container(),
          ],
        )
      ),
    );
  }
}
