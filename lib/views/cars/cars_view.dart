import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';
import 'package:transport/widgets/cars/cars_item_view.dart';
class CarsView extends StatelessWidget {
  CarsView({Key? key}) : super(key: key);
  ApiService api = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
      future: api.carsIndexRequest(carsPath),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return Column(
                children: [
                  Text("Наш Автопарк"),
                  Expanded(
                      child: Container(
                        constraints: BoxConstraints(minWidth: 300, maxWidth: 800),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisCount: 1,
                            shrinkWrap: true,
                            children: snapshot.data!.map((e) => CarsItemView(e, (){})).toList()
                        ),
                      ),
                  ),
                ],

          );

        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
