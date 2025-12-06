
import '../../../../data/models/toppings_model.dart';

sealed class ToppingsState {}

final class ToppingsInitial extends ToppingsState {}

final class ToppingsLoading extends ToppingsState {}

final class ToppingsSuccess extends ToppingsState {
  final List<ToppingsModel> toppingsModel;

  ToppingsSuccess({required this.toppingsModel});
}

final class ToppingsFailure extends ToppingsState {
  final String errMessage;

  ToppingsFailure({required this.errMessage});
}
