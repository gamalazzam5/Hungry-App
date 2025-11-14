import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';

import '../../../core/routes/app_router.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final int itemCount = 6;
  late List<int> quantity;

  @override
  void initState() {
    quantity = List.generate(itemCount, (_) => 1);
    super.initState();
  }

  void onAdd(int index) {
    setState(() {
      quantity[index]++;
    });
  }

  void onMinus(int index) {
    setState(() {
      if (quantity[index] > 1) {
        quantity[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 120, top: 30),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return CartItem(
              title: 'Hamburger',
              desc: 'Veggie Burger',
              image: 'assets/test/image 6.png',
              number: quantity[index],
              onAdd: () {
                onAdd(index);
              },
              onMinus: () {
                onMinus(index);
              },
              onRemove: () {},
            );
          },
        ),
      ),
      bottomSheet: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
        ),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text('Total', style: Styles.boldTextStyle20),
                Text('\$18.9', style: Styles.boldTextStyle20),
              ],
            ),
            CustomButton(text: 'Checkout', onTap: () {
              GoRouter.of(context).push(AppRoutePaths.checkout);
            }),
          ],
        ),
      ),
    );
  }
}
