
sealed class SaveOrderState {}

final class SaveOrderInitial extends SaveOrderState {}
final class SaveOrderLoading extends SaveOrderState {}
final class SaveOrderSuccess extends SaveOrderState {}
final class SaveOrderFailure extends SaveOrderState {
  final String errMessage;

  SaveOrderFailure({required this.errMessage});
}
