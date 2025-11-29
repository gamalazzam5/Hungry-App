import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/routes/app_router.dart';
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

  Future<void> getCartData() async {
    try {
      final res = await cartRepo.getCartData();
      setState(() {
        cartResponse = res;
        quantity = List.generate(res.data.items.length, (_) => 1);
      });
    } catch (_) {}
  }

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  void onAdd(int index) => setState(() => quantity[index]++);
  void onMinus(int index) => setState(() {
    if (quantity[index] > 1) quantity[index]--;
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = cartResponse == null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
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
                desc: item?.price ?? "",
                image: item?.image ?? "",
                number: isLoading ? 1 : quantity[index],
                onAdd: isLoading ? null : () => onAdd(index),
                onMin: isLoading ? null : () => onMinus(index),
                onRemove: isLoading ? null : () {},
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
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
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
                Text("\$${cartResponse?.data.totalPrice ?? "--"}",
                    style: Styles.boldTextStyle16),
              ],
            ),
            CustomButton(
              text: "Checkout",
              onTap: isLoading
                  ? null
                  : () => GoRouter.of(context).push(AppRoutePaths.checkout),
            ),
          ],
        ),
      ),
    );
  }
}
