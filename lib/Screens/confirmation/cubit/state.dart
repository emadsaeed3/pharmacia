abstract class OrdersStates {}

class OrdersStateInitial extends OrdersStates {}

class OrdersStateLoading extends OrdersStates {}
class OrdersStateSuccess extends OrdersStates {}
class OrdersStateError extends OrdersStates {
  final error;

  OrdersStateError(this.error);
}