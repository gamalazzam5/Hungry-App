import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../home/data/models/toppings_model.dart';
import '../widgets/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productImage});

  final String productImage;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = .5;
  int? selectedToppingIndex;

  final ProductRepo productRepo = ProductRepo();
  List<ToppingsModel>? toppings;
  List<ToppingsModel>? options;

  Future<void> getToppings() async {
    final response = await productRepo.getToppings();
    setState(() => toppings = response);
  }

  Future<void> getOptions() async {
    final response = await productRepo.getOptions();
    setState(() => options = response);
  }

  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool loadingToppings = toppings == null;
    final bool loadingOptions = options == null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                image: widget.productImage,
                value: value,
                onChanged: (v) => setState(() => value = v),
              ),
              const Gap(30),

              Text('Toppings', style: Styles.boldTextStyle20),
              const Gap(20),

              Skeletonizer(
                enabled: loadingToppings,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      loadingToppings ? 4 : toppings!.length,
                          (index) {
                        final topping = loadingToppings
                            ? ToppingsModel(
                          id: 0,
                          name: 'Loading...',
                          image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuutX8HduKl2eiBeqSWo1VdXcOS9UxzsKhQ&s',
                        )
                            : toppings![index];

                        final isSelected = selectedToppingIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ToppingCard(
                            imageUrl: topping.image,
                            title: topping.name,
                            onAdd: loadingToppings
                                ? (){}
                                : () => setState(() => selectedToppingIndex = index),
                            color: isSelected
                                ? Colors.green.withOpacity(0.2)
                                : AppColors.primary.withOpacity(0.1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const Gap(50),

              Text('Side options', style: Styles.boldTextStyle20),
              const Gap(8),

              Skeletonizer(
                enabled: loadingOptions,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      loadingOptions ? 4 : options!.length,
                          (index) {
                        final option = loadingOptions
                            ? ToppingsModel(
                          id: 0,
                          name: 'Loading...',
                          image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuutX8HduKl2eiBeqSWo1VdXcOS9UxzsKhQ&s',
                        )
                            : options![index];

                        final isSelected = selectedToppingIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ToppingCard(
                            imageUrl: option.image,
                            title: option.name,
                            onAdd: loadingOptions
                                ? (){}
                                : () => setState(() => selectedToppingIndex = index),
                            color: isSelected
                                ? Colors.green.withOpacity(0.2)
                                : AppColors.primary.withOpacity(0.1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const Gap(100),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.4),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: Styles.boldTextStyle20),
                Text('\$18.9', style: Styles.boldTextStyle20),
              ],
            ),
            CustomButton(
              text: 'Add To Cart',
              onTap: () {},
              horizontalPadding: 8,
            ),
          ],
        ),
      ),
    );
  }
}
