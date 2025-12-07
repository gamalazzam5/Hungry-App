
sealed class RemoveItemState {}

final class RemoveItemInitial extends RemoveItemState {}
final class RemoveItemLoading extends RemoveItemState {}
final class RemoveItemSuccess extends RemoveItemState {}
final class RemoveItemFailure extends RemoveItemState {
  final String errMessage;
  RemoveItemFailure({required this.errMessage});
}
