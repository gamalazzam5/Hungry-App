
import 'package:hungry/features/orderHistory/data/models/Data.dart';

sealed class OrderHistoryState {}

final class OrderHistoryInitial extends OrderHistoryState {}
final class OrderHistoryLoading extends OrderHistoryState {}
final class OrderHistoryFailure extends OrderHistoryState {
  final String errMessage;

  OrderHistoryFailure({required this.errMessage});
}
final class OrderHistorySuccess extends OrderHistoryState {
  final List<Data> orders;

  OrderHistorySuccess(this.orders);
}
