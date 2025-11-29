import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../home/data/models/toppings_model.dart';
import '../widgets/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = .5;
  List<int> selectedTopping = [];
  List<int> selectedOptions = [];

  final ProductRepo productRepo = ProductRepo();
  List<ToppingsModel>? toppings;
  List<ToppingsModel>? options;
  bool cartLoading = false;

  Future<void> getToppings() async {
    final response = await productRepo.getToppings();
    setState(() => toppings = response);
  }

  Future<void> getOptions() async {
    final response = await productRepo.getOptions();
    setState(() => options = response);
  }

  ///cart
  CartRepo cartRepo = CartRepo();

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
                image: widget.productModel.image,
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
                                image:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuutX8HduKl2eiBeqSWo1VdXcOS9UxzsKhQ&s',
                              )
                            : toppings![index];

                        final isSelected = selectedTopping.contains(topping.id);

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ToppingCard(
                            imageUrl: topping.image,
                            title: topping.name,
                            onAdd: loadingToppings
                                ? () {}
                                : () {
                                    final id = topping.id;
                                    if (selectedTopping.contains(id)) {
                                      setState(() {
                                        selectedTopping.remove(id);
                                      });
                                    } else {
                                      setState(() {
                                        selectedTopping.add(id);
                                      });
                                    }
                                  },
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
                                image:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuutX8HduKl2eiBeqSWo1VdXcOS9UxzsKhQ&s',
                              )
                            : options![index];

                        final isSelected = selectedOptions.contains(option.id);

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ToppingCard(
                            imageUrl: option.image,
                            title: option.name,
                            onAdd: loadingOptions
                                ? () {}
                                : () {
                                    final id = option.id;
                                    if (selectedOptions.contains(id)) {
                                      setState(() {
                                        selectedOptions.remove(id);
                                      });
                                    } else {
                                      setState(() {
                                        selectedOptions.add(id);
                                      });
                                    }
                                  },
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
              withIcon: true,
              iconData: CupertinoIcons.cart_badge_plus,
              iconColor: Colors.white,
              isLoading: cartLoading,
              text: 'Add To Cart',
              horizontalPadding: 10,
              onTap: () async {
                try {
                  setState(() {
                    cartLoading = true;
                  });
                  final cartItem = CartModel(
                    productId: int.parse(widget.productModel.id),
                    quantity: 1,
                    spicy: value,
                    toppings: selectedTopping,
                    sideOptions: selectedOptions,
                  );
                  await cartRepo.addToCart(
                    CartRequestModel(cartItems: [cartItem]),
                  );
                  setState(() {
                    cartLoading = false;
                  });
                  if (!mounted) return;
                  AppSnackBar.showSuccess(context, 'Item added to cart');
                } catch (e) {
                  setState(() {
                    cartLoading = false;
                  });
                  AppSnackBar.showError(context, e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
