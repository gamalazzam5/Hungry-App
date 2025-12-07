import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/core/utils/custom_snack_bar.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/presentation/manager/cubits/options_cubit/options_cubit.dart';
import 'package:hungry/features/home/presentation/manager/cubits/options_cubit/options_states.dart';
import 'package:hungry/features/product/presentation/manager/add_to_cart_cubit.dart';
import 'package:hungry/features/product/presentation/manager/add_to_cart_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../home/presentation/manager/cubits/toppings_cubit/toppings_cubit.dart';
import '../../../home/presentation/manager/cubits/toppings_cubit/toppings_states.dart';
import '../widgets/spicy_slider.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: .start,
            children: [
              /// SLIDER
              SpicySlider(
                image: widget.productModel.image,
                value: value,
                onChanged: (v) => setState(() => value = v),
              ),

              const Gap(30),
              Text('Toppings', style: Styles.boldTextStyle20),
              const Gap(20),

              BlocBuilder<ToppingsCubit, ToppingsState>(
                builder: (context, state) {
                  if (state is ToppingsLoading) {
                    return Skeletonizer(enabled: true, child: _loadingRow());
                  }

                  if (state is ToppingsSuccess) {
                    return SingleChildScrollView(
                      scrollDirection: .horizontal,
                      child: Row(
                        children: List.generate(state.toppingsModel.length, (
                          index,
                        ) {
                          final topping = state.toppingsModel[index];
                          final isSelected = selectedTopping.contains(
                            topping.id,
                          );

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ToppingCard(
                              imageUrl: topping.image,
                              title: topping.name,
                              onAdd: () {
                                final id = topping.id;
                                setState(() {
                                  isSelected
                                      ? selectedTopping.remove(id)
                                      : selectedTopping.add(id);
                                });
                              },
                              color: isSelected
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : AppColors.primary.withValues(alpha: 0.1),
                            ),
                          );
                        }),
                      ),
                    );
                  }

                  if (state is ToppingsFailure) {
                    return Text(state.errMessage);
                  }

                  return const SizedBox();
                },
              ),

              const Gap(50),
              Text('Side options', style: Styles.boldTextStyle20),
              const Gap(8),

              BlocBuilder<OptionsCubit, OptionsState>(
                builder: (context, state) {
                  if (state is OptionsLoading) {
                    return Skeletonizer(enabled: true, child: _loadingRow());
                  }

                  if (state is OptionsSuccess) {
                    return SingleChildScrollView(
                      scrollDirection: .horizontal,
                      child: Row(
                        children: List.generate(state.optionsModel.length, (
                          index,
                        ) {
                          final option = state.optionsModel[index];
                          final isSelected = selectedOptions.contains(
                            option.id,
                          );

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ToppingCard(
                              imageUrl: option.image,
                              title: option.name,
                              onAdd: () {
                                final id = option.id;
                                setState(() {
                                  isSelected
                                      ? selectedOptions.remove(id)
                                      : selectedOptions.add(id);
                                });
                              },
                              color: isSelected
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : AppColors.primary.withValues(alpha: 0.1),
                            ),
                          );
                        }),
                      ),
                    );
                  }

                  if (state is OptionsFailure) {
                    return Text(state.errMessage);
                  }

                  return const SizedBox();
                },
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
              color: Colors.grey.withValues(alpha: .4),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        height: 90,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text('Total', style: Styles.boldTextStyle20),
                Text(
                  '\$${widget.productModel.price}',
                  style: Styles.boldTextStyle20,
                ),
              ],
            ),

            BlocConsumer<AddToCartCubit, AddToCartState>(
              listener: (_, state) {
                if (state is AddToCartSuccess) {
                  AppSnackBar.showSuccess(
                    context,
                    "Item added to cart Successfully 🔥",
                  );
                } else if (state is AddToCartFailure) {
                  AppSnackBar.showError(context, state.errMessage);
                }
              },
              builder: (context, state) {
                if (state is AddToCartLoading) {
                  return CustomButton(
                    withIcon: true,
                    iconData: CupertinoIcons.cart_badge_plus,
                    iconColor: Colors.white,
                    text: 'Add To Cart',
                    horizontalPadding: 10,
                    isLoading: true,
                  );
                } else {
                  return CustomButton(
                    withIcon: true,
                    iconData: CupertinoIcons.cart_badge_plus,
                    iconColor: Colors.white,
                    text: 'Add To Cart',
                    horizontalPadding: 10,
                    onTap: () async {
                      final cartItem = CartModel(
                        productId: int.parse(widget.productModel.id),
                        quantity: 1,
                        spicy: value,
                        toppings: selectedTopping,
                        sideOptions: selectedOptions,
                      );
                      await context.read<AddToCartCubit>().addToCart(
                        CartRequestModel(cartItems: [cartItem]),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// -------------------------
  ///  SKELETON ROW BUILDER
  /// -------------------------
  Widget _loadingRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ToppingCard(
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuutX8HduKl2eiBeqSWo1VdXcOS9UxzsKhQ&s',
              title: 'Loading...',
              onAdd: () {},
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
        ),
      ),
    );
  }
}
