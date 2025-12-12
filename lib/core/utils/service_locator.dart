import 'package:get_it/get_it.dart';
import 'package:hungry/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:hungry/features/auth/data/repos/auth_repo.dart';
import 'package:hungry/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry/features/auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';
import 'package:hungry/features/cart/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/data/repos/cart_repo_impl.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/get_cart_cubit/get_cart_cubit.dart';
import 'package:hungry/features/checkout/data/data_sources/remote_data_sources/order_remote_data_source.dart';
import 'package:hungry/features/checkout/data/repos/order_repo.dart';
import 'package:hungry/features/checkout/presentation/manager/save_order_cubit.dart';
import 'package:hungry/features/home/data/data_source/product_remote_data_source.dart';
import 'package:hungry/features/home/data/data_source/product_remote_data_source_impl.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import 'package:hungry/features/home/data/repos/product_repo_impl.dart';
import 'package:hungry/features/home/presentation/manager/cubits/product_cubit/product_cubit.dart';
import 'package:hungry/features/orderHistory/data/repos/order_history_repo.dart';
import 'package:hungry/features/orderHistory/presentation/manager/order_history_cubit.dart';

import '../../features/auth/data/data_source/auth_remote_data_source_impl.dart';
import '../../features/cart/data/data_sources/remote_data_source/cart_remote_data_source_impl.dart';
import '../../features/orderHistory/data/data_sources/remote_data_source/order_remote_data_source.dart';
import '../../features/product/presentation/manager/add_to_cart_cubit.dart';
import '../network/api_service.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: getIt()),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));

  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiService: getIt()),
  );
  getIt.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(productRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ProductCubit>(() => ProductCubit(getIt()));
  getIt.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(apiService: getIt()),
  );
  getIt.registerLazySingleton<CartRepo>(
    () => CartRepoImpl(cartRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<AddToCartCubit>(() => AddToCartCubit(getIt()));
  getIt.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(apiService: getIt()),
  );
  getIt.registerLazySingleton<GetCartCubit>(() => GetCartCubit(getIt()));
  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(orderRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<SaveOrderCubit>(() => SaveOrderCubit(getIt()));
  getIt.registerLazySingleton<OrderHistoryRemoteDataSource>(() => OrderHistoryRemoteDataSourceImpl(apiService: getIt()));
  getIt.registerLazySingleton<OrderHistoryRepo>(() => OrderHistoryImpl(orderRemoteDataSource: getIt()));
  getIt.registerLazySingleton<OrderHistoryCubit>(() => OrderHistoryCubit(getIt()));
}
