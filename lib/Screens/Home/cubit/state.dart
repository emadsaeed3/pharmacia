abstract class AllPharmaciesStates {}

class AllPharmaciesStateInitial extends AllPharmaciesStates {}

class AllPharmaciesStateLoading extends AllPharmaciesStates {}

class AllPharmaciesStateSuccess extends AllPharmaciesStates {}

class AllPharmaciesStateError extends AllPharmaciesStates
{
  final error;

  AllPharmaciesStateError(this.error);
}

class CheckIndexState extends AllPharmaciesStates {}
