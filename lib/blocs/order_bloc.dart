import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/models/car.dart';
import 'package:transport/models/service.dart';
import 'package:transport/models/user.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';

@immutable
abstract class OrderEvent {}
class OrderInitialEvent extends OrderEvent {}
class OrderSetCarEvent extends OrderEvent {}
class OrderCreateEvent extends OrderEvent {
  List<int> servicesId;
  int carId;
  String name;
  String phone;
  String dateTime;
  int? userId;

  OrderCreateEvent(this.name, this.phone, this.dateTime,this.servicesId, this.carId, this.userId);
}

@immutable
abstract class OrderState {}
class OrderInitialState extends OrderState {}
class OrderLoadInProcessState extends OrderState {}
class OrderLoadedState extends OrderState {
  final List<Car> cars;
  final List<Service> services;
  final User? user;

  OrderLoadedState(this.cars, this.services, this.user);
}
class OrderInProcessState extends OrderState {}
class OrderCreatedState extends OrderState {}
class OrderFailureState extends OrderState {
  String error;
  OrderFailureState(this.error);
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _sessionDataProvider = SessionDataProvider();

  OrderBloc() : super(OrderInitialState()) {
    on<OrderEvent>((event, emit) async {
      if (event is OrderInitialEvent) {
        await onOrderInitialEvent(event, emit);
      } else if (event is OrderCreateEvent) {
        await onOrderCreateEvent(event, emit);
      } else if (event is OrderSetCarEvent) {
        await onOrderSetCarEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onOrderInitialEvent(OrderInitialEvent event, Emitter<OrderState> emit) async {
    List<Car> cars = [];
    List<Service> services = [];
    User? user = null;
    try {
      emit(OrderLoadInProcessState());
      cars = await ApiService().carsIndexRequest(carsPath);
      services = await ApiService().servicesIndexRequest(servicesPath);
      var userId = await _sessionDataProvider.getAccountId();
      if (userId != null) {
        //user = await ApiService().
      }
      emit(OrderLoadedState(cars, services, user));
    } catch (e) {
      emit(OrderFailureState(e.toString()));
    }
  }
  onOrderCreateEvent(OrderCreateEvent event, Emitter<OrderState> emit){
    try {
      emit(OrderInProcessState());

      emit(OrderCreatedState());
    } catch (e) {
      emit(OrderFailureState(e.toString()));
    }
  }

  onOrderSetCarEvent(OrderSetCarEvent event, Emitter<OrderState> emit) {

  }
}
