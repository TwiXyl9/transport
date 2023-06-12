import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/order/stepper/cars_step.dart';
import 'package:transport/widgets/order/stepper/date_step.dart';
import 'package:transport/widgets/order/stepper/map_step.dart';
import 'package:transport/widgets/order/stepper/person_info_step.dart';
import 'package:transport/widgets/order/stepper/services_step.dart';
import 'package:transport/widgets/order/stepper/total/total_step.dart';
import 'package:transport/widgets/order/total_table_view.dart';
import 'package:transport/models/route.dart' as OrderRoute;
import 'package:transport/widgets/status/status_dropdown.dart';
import 'package:google_maps_webservice/places.dart';
import '../../config/secrets.dart';
import '../../models/car.dart';
import '../../models/cargo_type.dart';
import '../../models/order.dart';
import '../../models/order_service.dart';
import '../../models/point.dart';
import '../../models/user.dart';
import '../cargo_type/cargo_type_dropdown.dart';
import '../components/custom_button.dart';
import '../components/custom_circular_progress_indicator.dart';
import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class AdminOrderDialog extends StatefulWidget {
  final Order order;
  AdminOrderDialog(this.order);

  @override
  State<AdminOrderDialog> createState() => _AdminOrderDialogState();
}

class _AdminOrderDialogState extends State<AdminOrderDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateTimeController = TextEditingController();
  PlaceDetails departure = PlaceDetails(name: '', placeId: '');
  PlaceDetails arrival = PlaceDetails(name: '', placeId: '');
  String selectedStage = '';
  late double totalPrice = 0;
  User user = new User.createGuest();
  Car selectedCar = new Car(0);
  CargoType selectedCargoType = new CargoType(0, '');
  final personInfoFormKey = GlobalKey<FormState>();
  final dateFormKey = GlobalKey<FormState>();
  final mapFormKey = GlobalKey<FormState>();
  late List<OrderService> selectedServices = [];
  late Order _order;
  final GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Secrets.API_KEY_PLACES,
      baseUrl: 'https://maps.googleapis.com/maps/api',
      apiHeaders: {
        'X-Requested-With': 'XMLHttpRequest',
        'Access-Control-Allow-Origin' : '*',
      }
  );
  void initState() {
    _order = widget.order;
    nameController.text = _order.name;
    phoneController.text = _order.phone;
    dateTimeController.text = _order.dateTime;
    selectedCargoType = _order.cargoType;
    selectedStage = _order.stage!;
    selectedCar = _order.car;
    selectedServices = _order.services;
    super.initState();
    getPlacesResults();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              constraints: BoxConstraints(minHeight: 200, maxHeight: MediaQuery.of(context).size.height, minWidth: 200, maxWidth: 500),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Статус"),
                    StatusDropdown(selectedStage, stagesCallback),
                    PersonInfoStep(formKey, nameController, phoneController),
                    SizedBox(height: 20,),
                    DateStep(dateFormKey, dateTimeController),
                    SizedBox(height: 40,),
                    if (departure.placeId.isNotEmpty && departure.placeId.isNotEmpty) MapStep(departure, arrival, mapFormKey, mapCallback),
                    state is OrderLoadedState?
                    Column(
                      children: [
                        Text("Тип груза"),
                        CargoTypeDropdown(state.cargoTypes, selectedCargoType, cargoTypesCallback,),
                        SizedBox(height: 20,),
                        CarsStep(carCallback: carsCallback, selectedCar: selectedCar, cars: state.cars),
                        SizedBox(height: 20,),
                        ServicesStep(
                            selectedServices: selectedServices.length == 0 ? state.services.map((e) => new OrderService(0, 0, e)).toList() : selectedServices,
                            servicesCallback: servicesCallback,
                            services: state.services
                        ),
                        SizedBox(height: 20,),
                        TotalTableView(
                          selectedCar.id != 0 ? selectedCar : state.cars[0],
                          selectedServices,
                          totalPrice = getTotalPrice(),)
                      ],
                    ) :
                    CustomCircularProgressIndicator(),
                    CustomButton(btnText: 'Сохранить', onTap: saveOrder, btnColor: Colors.green)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  mapCallback(dep, arr){
    departure = dep;
    arrival = arr;
  }

  stagesCallback(val) {
    setState(() {
      selectedStage = val;
    });
  }

  carsCallback(val) {
    setState(() {
      selectedCar = val;
    });
  }

  servicesCallback(val){
    setState(() {
      selectedServices = val;
    });
  }

  cargoTypesCallback(val){
    setState(() {
      selectedCargoType = val;
    });
  }

  Future<void> getPlacesResults() async {
    var dep = (await _places.getDetailsByPlaceId(_order.route.start_point.placeId)).result;
    var arr = (await _places.getDetailsByPlaceId(_order.route.end_point.placeId)).result;
    setState(() {
      departure = dep;
      arrival = arr;
    });
  }

  bool allIsEmpty(){
    return nameController.text.isEmpty && phoneController.text.isEmpty &&
        dateTimeController.text.isEmpty && selectedCar.id == 0 &&
        selectedCargoType.id == 0 && selectedServices.isEmpty;
  }

  double getTotalPrice(){
    double result = selectedCar.id! > 0 ? selectedCar.pricePerHour : 0;
    if (selectedServices.length > 0) {
      selectedServices.forEach((e) {
        result += e.amount * e.service.price;
      });
    }
    return result;
  }

  void saveOrder() {
    try {
      var bloc = context.read<OrderBloc>();
      _order.name = nameController.text;
      _order.phone = phoneController.text;
      _order.dateTime = dateTimeController.text;
      _order.totalPrice = totalPrice;
      _order.stage = selectedStage;
      _order.cargoType = selectedCargoType;
      _order.car = selectedCar;
      _order.services = selectedServices.where((e) => e.amount > 0).toList();
      _order.route.start_point = new Point(
          _order.route.start_point.id,
          departure.geometry!.location.lat,
          departure.geometry!.location.lng,
          departure.formattedAddress!,
          departure.placeId
      );
      _order.route.end_point = new Point(
          _order.route.end_point.id,
          arrival.geometry!.location.lat,
          arrival.geometry!.location.lng,
          arrival.formattedAddress!,
          arrival.placeId
      );
      bloc.add(UpdateOrderEvent(_order));
    } catch (error) {
      var errorMessage = error.toString();
      showDialog(
          context: context,
          builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
      );
    }
    Navigator.of(context).pop();
  }

}
