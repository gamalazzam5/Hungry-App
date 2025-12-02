import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../../auth/data/model/user_model.dart';
import '../../auth/data/repos/old_version_repo.dart';
import '../data/models/cart_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  GetCartResponse? cartResponse;
  CartRepo cartRepo = CartRepo();
  List<int> quantity = [];
  List<bool> isRemoving = [];
  bool isGuest = false;
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;

  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) setState(() => userModel = user);
  }

  double calculateTotal() {
    if (cartResponse == null) return 0;

    double total = 0;
    for (int i = 0; i < cartResponse!.data.items.length; i++) {
      final price =
          double.tryParse(cartResponse!.data.items[i].price.toString()) ?? 0;
      total += price * quantity[i];
    }
    return total;
  }

  Future<void> getCartData() async {
    try {
      final res = await cartRepo.getCartData();
      setState(() {
        cartResponse = res;
        quantity = List.generate(res.data.items.length, (_) => 1);
        isRemoving = List.generate(res.data.items.length, (_) => false);
      });
    } catch (_) {}
  }

  Future<void> removeItemFromCart(int index, int itemId) async {
    try {
      setState(() => isRemoving[index] = true);

      await cartRepo.removeItemFromCart(itemId);

      if (!mounted) return;
      setState(() {
        cartResponse!.data.items.removeAt(index);
        quantity.removeAt(index);
        isRemoving.removeAt(index);
      });

      AppSnackBar.showSuccess(context, "Item removed successfully");
    } catch (e) {
      if (!mounted) return;
      setState(() => isRemoving[index] = false);

      AppSnackBar.showError(context, e.toString());
    }
  }

  @override
  void initState() {
    getCartData();
    autoLogin();
    super.initState();
  }

  void onAdd(int index) => setState(() => quantity[index]++);

  void onMinus(int index) => setState(() {
    if (quantity[index] > 1) quantity[index]--;
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = cartResponse == null;

    if (!isGuest) {
      return RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        onRefresh: () async{
         await getCartData();
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
                  final item = isLoading ? null : cartResponse!.data.items[index];

                  return CartItem(
                    isSkeleton: isLoading,
                    text: item?.name ?? "",
                    desc: isLoading
                        ? ""
                        : "Spicy level: ${((double.tryParse(item?.spicy.toString() ?? "0") ?? 0) * 100).toStringAsFixed(0)}%",
                    image: item?.image ?? "",
                    number: isLoading ? 1 : quantity[index],
                    onAdd: isLoading ? null : () => onAdd(index),
                    onMin: isLoading ? null : () => onMinus(index),
                    isLoadingRemove: isLoading ? false : isRemoving[index],
                    onRemove: isLoading
                        ? null
                        : () {
                            removeItemFromCart(index, item!.itemId);
                          },
                  );
                },
              ),
            ),
          ),

          bottomSheet: Container(
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
                    Text("Total Amount", style: Styles.boldTextStyle16),
                    Text(
                      isLoading
                          ? "--.--"
                          : "\$${calculateTotal().toStringAsFixed(2)}",
                      style: Styles.boldTextStyle16,
                    ),
                  ],
                ),
                CustomButton(
                  text: "Checkout",
                  onTap: isLoading
                      ? null
                      : () => GoRouter.of(context).push(
                          AppRoutePaths.checkout,
                          extra: {
                            'totalPrice': calculateTotal().toStringAsFixed(2),
                            'items': cartResponse!.data.items,
                            'quantities': quantity,
                          },

                        ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: .center,
        children: [
          Center(
            child: Text(
              'This is guest Mode please Login',
              style: Styles.boldTextStyle16,
            ),
          ),
          Gap(24),
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
