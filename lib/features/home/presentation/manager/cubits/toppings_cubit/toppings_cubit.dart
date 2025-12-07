import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import 'package:hungry/features/home/presentation/manager/cubits/toppings_cubit/toppings_states.dart';

class ToppingsCubit extends Cubit<ToppingsState> {
  final ProductRepo repo;

  ToppingsCubit(this.repo) : super(ToppingsInitial());

  Future<void> getToppings() async {
    emit(ToppingsLoading());
    try {
      final result = await repo.getToppings();
      emit(ToppingsSuccess(toppingsModel: result));
    } catch (e) {
      emit(ToppingsFailure(errMessage: e.toString()));
    }
  }
}
