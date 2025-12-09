import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';
import 'package:hungry/features/checkout/data/models/Items.dart';
import 'package:hungry/features/checkout/presentation/manager/save_order_cubit.dart';
import 'package:hungry/features/checkout/presentation/manager/save_order_state.dart';
import '../../../../core/shared/custom_button.dart';
import '../../../../core/utils/custom_snack_bar.dart';
import '../../../auth/data/model/user_model.dart';
import '../../data/models/Order_model.dart';
import '../widgets/order_details.dart';
import '../widgets/payment_tile.dart';
import '../widgets/success_dialog.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.totalPrice,
    required this.items,
    required this.quantities,
  });

  final String totalPrice;
  final List<CartItemModel> items;
  final List<int> quantities;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';
  bool value = false;
  UserModel? userModel;
  late OrderModel orderModel;
  OrderModel buildOrderModel() {
    final items = List<Items>.generate(widget.items.length, (index) {
      final product = widget.items[index];
      final qty = widget.quantities[index];

      return Items(
        productId: product.productId,
        quantity: qty,
        spicy: double.tryParse(product.spicy.toString()) ?? 0,
        toppings: product.toppings.map((e) => e.id).toList(),
        sideOptions: product.sideOptions.map((e) => e.id).toList(),
      );
    });

    return OrderModel(items: items);
  }
 late SaveOrderCubit saveOrderCubit;


  @override
  void initState() {
    super.initState();
    orderModel = buildOrderModel();
    saveOrderCubit = context.read<SaveOrderCubit>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, scrolledUnderElevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const Text('Order Summary', style: Styles.boldTextStyle16),
              const Gap(20),
              OrderDetails(
                order: widget.totalPrice,
                taxes: "1.7",
                fees: "1.5",
                total: (double.parse(widget.totalPrice) + 1.7 + 1.5)
                    .toStringAsFixed(2),
              ),
              const Gap(24),
              Text('Payment methods', style: Styles.boldTextStyle20),
              const Gap(20),
              PaymentTile(
                onTap: () => setState(() => selectedMethod = 'Cash'),
                title: 'Cash on Delivery',
                tileColor: const Color(0xFF3C2F2F),
                icon: 'assets/icon/dollor.png',
                value: 'Cash',

                groupValue: selectedMethod,
                onChanged: (v) {
                  setState(() {
                    selectedMethod = v!;
                  });
                },
              ),
              const Gap(24),
              userModel?.visa == null
                  ? SizedBox.shrink()
                  : PaymentTile(
                      onTap: () => setState(() => selectedMethod = 'Visa'),
                      title: 'Debit card',
                      subTitle: userModel?.visa,
                      icon: 'assets/icon/visa.png',
                      tileColor: Colors.blue.shade900,
                      value: 'Visa',
                      groupValue: selectedMethod,
                      onChanged: (v) {
                        setState(() {
                          selectedMethod = v!;
                        });
                      },
                    ),
              Gap(5),
              userModel?.visa == null
                  ? SizedBox.shrink()
                  : Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.lightGreen,
                          value: value,
                          onChanged: (v) {
                            setState(() {
                              value = v!;
                            });
                          },
                        ),
                        Text(
                          'Save card details for future payments',
                          style: Styles.textStyle14.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
              Gap(200),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
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
        padding: EdgeInsets.all(14),
        height: 90,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text('Total', style: Styles.boldTextStyle20),
                Text(
                  '\$${(double.parse(widget.totalPrice) + 1.7 + 1.5).toStringAsFixed(2)}',
                  style: Styles.boldTextStyle20,
                ),
              ],
            ),
            BlocConsumer<SaveOrderCubit,SaveOrderState>(
listener: (_,state){
  if(state is SaveOrderFailure){
    if (!context.mounted) return;
    AppSnackBar.showError(context, state.errMessage);
  }
  if(state is SaveOrderSuccess){
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => successDialog(context),
    );
  }
},
              builder: (_,state){
                bool loading = state is SaveOrderLoading;
                return CustomButton(
                  iconData: CupertinoIcons.money_dollar_circle,
                  isLoading: loading ,

                  text: 'Pay now',
                  withIcon: true,
                  horizontalPadding: 20,

                  onTap: () async {
                    context.read<SaveOrderCubit>().saveOrder(orderModel);
                  },
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
