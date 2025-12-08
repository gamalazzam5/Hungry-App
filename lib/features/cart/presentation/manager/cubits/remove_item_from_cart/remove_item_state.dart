
sealed class RemoveItemState {}

final class RemoveItemInitial extends RemoveItemState {}
final class RemoveItemLoading extends RemoveItemState {
  final int itemId;
  RemoveItemLoading({required this.itemId});
}
final class RemoveItemSuccess extends RemoveItemState {
}
final class RemoveItemFailure extends RemoveItemState {
  final String errMessage;
  RemoveItemFailure({required this.errMessage});
}
