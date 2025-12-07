import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/get_cart_cubit/get_cart_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../auth/data/repos/old_version_repo.dart';
import '../../data/models/cart_model.dart';
import '../manager/cubits/get_cart_cubit/get_cart_state.dart';
import '../widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool isGuest = false;
  AuthRepo authRepo = AuthRepo();

  late GetCartCubit getCartCubit;

  @override
  void initState() {
    super.initState();
    getCartCubit = context.read<GetCartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return BlocBuilder<GetCartCubit, GetCartState>(
        builder: (context, state) {
          final bool isLoading =
              state is GetCartLoading || state is GetCartInitial;

          if (state is GetCartFailure) {
            return Center(
              child: Text(state.errMessage, style: Styles.boldTextStyle16),
            );
          }

          GetCartResponse? cartResponse;
          List<int> quantities = [];

          if (state is GetCartSuccess) {
            cartResponse = state.cartResponse;
            quantities = state.quantities;
          }

          return RefreshIndicator(
            backgroundColor: Colors.white,
            color: AppColors.primary,
            onRefresh: () async {
              await getCartCubit.getCartData();
            },
            child: Scaffold(
              appBar: AppBar(backgroundColor: Colors.white, toolbarHeight: 0),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Skeletonizer(
                  enabled: isLoading,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 120, top: 30),
                    itemCount: isLoading ? 4 : cartResponse!.data.items.length,
                    itemBuilder: (context, index) {
                      final item = isLoading
                          ? null
                          : cartResponse!.data.items[index];

                      return CartItem(
                        isSkeleton: isLoading,
                        text: item?.name ?? "",
                        desc: isLoading
                            ? ""
                            : "Spicy level: ${((double.tryParse(item?.spicy.toString() ?? "0") ?? 0) * 100).toStringAsFixed(0)}%",
                        image: item?.image ?? "",
                        number: isLoading ? 1 : quantities[index],
                        onAdd: isLoading
                            ? null
                            : () => getCartCubit.increment(index),
                        onMin: isLoading
                            ? null
                            : () => getCartCubit.decrement(index),

                        /// REMOVE (later using RemoveItemCubit)
                        isLoadingRemove: false,
                        onRemove: isLoading
                            ? null
                            : () {
                                AppSnackBar.showSuccess(
                                  context,
                                  "Remove will be added in next step 💪",
                                );
                              },
                      );
                    },
                  ),
                ),
              ),
              bottomSheet: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: .3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text("Total Amount", style: Styles.boldTextStyle16),
                        Text(
                          isLoading || state is! GetCartSuccess
                              ? "--.--"
                              : "\$${state.total.toStringAsFixed(2)}",
                          style: Styles.boldTextStyle16,
                        ),
                      ],
                    ),
                    CustomButton(
                      text: "Checkout",
                      onTap: (isLoading || state is! GetCartSuccess)
                          ? null
                          : () => GoRouter.of(context).push(
                              AppRoutePaths.checkout,
                              extra: {
                                'totalPrice': state.total.toStringAsFixed(2),
                                'items': state.cartResponse.data.items,
                                'quantities': state.quantities,
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'This is guest Mode please Login',
              style: Styles.boldTextStyle16,
            ),
          ),
          const Gap(24),
          CustomButton(
            width: 200,
            height: 50,
            textColor: Colors.white,
            onTap: () {
              GoRouter.of(context).go(AppRoutePaths.loginView);
            },
            text: 'Go To Login',
          ),
        ],
      );
    }
  }
}
