import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/get_cart_cubit/get_cart_cubit.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/remove_item_from_cart/remove_item_cubit.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/remove_item_from_cart/remove_item_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/routes/app_router.dart';
import '../manager/cubits/get_cart_cubit/get_cart_state.dart';
import '../widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool isGuest = false;

  late GetCartCubit getCartCubit;

  @override
  void initState() {
    super.initState();
    getCartCubit = context.read<GetCartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    if (isGuest) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("This is guest Mode, please Login"),
            SizedBox(height: 20),
          ],
        ),
      );
    }

    return BlocConsumer<GetCartCubit, GetCartState>(
      listener: (context, state) {
        if (state is GetCartFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppSnackBar.showError(context, state.errMessage);
          });
        }
      },
      builder: (context, state) {
        final bool isLoading = state is GetCartLoading || state is GetCartInitial;

        if (state is GetCartSuccess) {
          final items = state.cartResponse.data.items;
          final quantities = state.quantities;

          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.white, toolbarHeight: 0),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 120, top: 30),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return BlocBuilder<RemoveItemCubit, RemoveItemState>(
                    builder: (_, removeState) {
                      final isRemoving = removeState is RemoveItemLoading &&
                          removeState.itemId == item.itemId;

                      return CartItem(
                        isSkeleton: false,
                        text: item.name,
                        desc:
                        "Spicy level: ${(double.parse(item.spicy) * 100).toStringAsFixed(0)}%",
                        image: item.image,
                        number: quantities[index],
                        onAdd: () => getCartCubit.increment(index),
                        onMin: () => getCartCubit.decrement(index),

                        isLoadingRemove: isRemoving,
                        onRemove: () async {
                          final removeCubit = context.read<RemoveItemCubit>();

                          await removeCubit.removeItemFromCart(item.itemId);

                          if (!mounted) return;

                          if (removeCubit.state is RemoveItemSuccess) {
                            getCartCubit.removeItemLocal(index);
                            if(!context.mounted) return;
                            AppSnackBar.showSuccess(
                                context, "Item removed successfully");
                          } else if (removeCubit.state is RemoveItemFailure) {
                            if(!context.mounted) return;
                            AppSnackBar.showError(
                                context,
                                (removeCubit.state as RemoveItemFailure)
                                    .errMessage);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),

            bottomSheet: _buildBottomSheet(state.total, state),
          );
        }

        if (isLoading) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 120, top: 30),
                  itemCount: 6,
                  itemBuilder: (_, _) => CartItem(
                    isSkeleton: true,
                    text: "",
                    desc: "",
                    image: "",
                    number: 1,
                    isLoadingRemove: false,
                    onAdd: null,
                    onMin: null,
                    onRemove: null,
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                const Text("Couldn't load cart ❌"),
                const Gap( 20),
               CustomButton(text: 'Retry',onTap: ()=>getCartCubit.getCartData(),
               )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheet(double total, GetCartSuccess state) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Total Amount",style: Styles.boldTextStyle16,),
              Text("\$${total.toStringAsFixed(2)}",style: Styles.boldTextStyle16,),
            ],
          ),
          CustomButton(
            text: "Checkout",
            onTap: () {
              GoRouter.of(context).push(
                AppRoutePaths.checkout,
                extra: {
                  'totalPrice': total.toStringAsFixed(2),
                  'items': state.cartResponse.data.items,
                  'quantities': state.quantities,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
