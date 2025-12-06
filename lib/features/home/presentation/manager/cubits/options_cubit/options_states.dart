
import '../../../../data/models/toppings_model.dart';

sealed class OptionsState {}

final class OptionsInitial extends OptionsState {}

final class OptionsLoading extends OptionsState {}

final class OptionsSuccess extends OptionsState {
  final List<ToppingsModel> optionsModel;

  OptionsSuccess({required this.optionsModel});
}

final class OptionsFailure extends OptionsState {
  final String errMessage;

  OptionsFailure({required this.errMessage});
}
