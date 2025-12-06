import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repos/product_repo.dart';
import 'options_states.dart';

class OptionsCubit extends Cubit<OptionsState> {
  final ProductRepo repo;

  OptionsCubit(this.repo) : super(OptionsInitial());

  Future<void> getOptions() async {
    emit(OptionsLoading());
    try {
      final options = await repo.getOptions();
      emit(OptionsSuccess( optionsModel: options));
    } catch (e) {
      emit(OptionsFailure( errMessage: e.toString(),));
    }
  }
}
