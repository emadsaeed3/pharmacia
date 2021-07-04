abstract class PaymentStates {}

class PaymentStateInitial extends PaymentStates {}
//
//
// class AddAddressStateLoading extends PaymentStates {}
// class AddAddressStateSuccess extends PaymentStates {}
// class AddAddressStateError extends PaymentStates {
//   final error;
//
//   AddAddressStateError(this.error);
// }
//
//
// class ShowAddressStateLoading extends PaymentStates {}
// class ShowAddressStateSuccess extends PaymentStates {}
// class ShowAddressStateError extends PaymentStates {
//   final error;
//
//   ShowAddressStateError(this.error);
// }
//
// class DeleteAddressStateLoading extends PaymentStates {}
// class DeleteAddressStateSuccess extends PaymentStates {}
// class DeleteAddressStateError extends PaymentStates {
//   final error;
//
//   DeleteAddressStateError(this.error);
// }

class CheckIndexButtonState extends PaymentStates {}

class OrderStateLoading extends PaymentStates {}
class OrderStateSuccess extends PaymentStates {}
class OrderStateError extends PaymentStates {
  final error;

  OrderStateError(this.error);
}