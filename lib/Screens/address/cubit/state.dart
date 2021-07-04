abstract class AddressStates {}

class AddressStateInitial extends AddressStates {}


class AddAddressStateLoading extends AddressStates {}
class AddAddressStateSuccess extends AddressStates {}
class AddAddressStateError extends AddressStates {
  final error;

  AddAddressStateError(this.error);
}


class ShowAddressStateLoading extends AddressStates {}
class ShowAddressStateSuccess extends AddressStates {}
class ShowAddressStateError extends AddressStates {
final error;

ShowAddressStateError(this.error);
}

class DeleteAddressStateLoading extends AddressStates {}
class DeleteAddressStateSuccess extends AddressStates {}
class DeleteAddressStateError extends AddressStates {
  final error;

  DeleteAddressStateError(this.error);
}

class CheckIndexState extends AddressStates {}
