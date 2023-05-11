import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    }
    void deleteType(){
      bloc.add(DeleteAdditionalServiceEvent(service));
      bloc.add(InitialAdditionalServiceEvent());
    }

    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Image.network(service.imageUrl),
            ),
            Column(
              children: [
                Text(service.name),
                Text('${service.price} б.р.')
              ],
            ),
            user.isAdmin()?
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
            ) : Container(),
          ],
        )
      ),
    );
  }
}
