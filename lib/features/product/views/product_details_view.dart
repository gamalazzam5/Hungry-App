import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';

import '../widgets/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = .5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SpicySlider(
                value: value,
                onChanged: (v) {
                  setState(() => value = v);
                },
              ),
              Gap(30),
              Text('Toppings', style: Styles.boldTextStyle20),
              Gap(20),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ToppingCard(
                        image: 'assets/test/pngwing 15.png',
                        title: "Tomatos",
                        onTap: () {},
                      ),
                    );
                  }),
                ),
              ),
              Gap(50),
              Text('Side options', style: Styles.boldTextStyle20),
              Gap(8),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ToppingCard(
                        image: 'assets/test/pngwing 15.png',
                        title: "Tomatos",
                        onTap: () {},
                      ),
                    );
                  }),
                ),
              ),
              Gap(16),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Total', style: Styles.boldTextStyle20),
                      Text('\$18.9', style: Styles.boldTextStyle20),
                    ],
                  ),
                  CustomButton(text: 'Add To Cart', onTap: () {}),
                ],
              ),
              Gap(100)
            ],
          ),
        ),
      ),
    );
  }
}
