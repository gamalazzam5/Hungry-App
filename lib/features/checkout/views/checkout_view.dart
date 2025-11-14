import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/features/checkout/widgets/order_details.dart';
import 'package:hungry/features/checkout/widgets/payment_tile.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, scrolledUnderElevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const Text('Order Summary', style: Styles.boldTextStyle16),
            const Gap(20),
            const OrderDetails(
              order: "18.1",
              taxes: "1.7",
              fees: "1.5",
              total: "20.1",
            ),
            const Gap(50),
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
            PaymentTile(
              onTap: () => setState(() => selectedMethod = 'Visa'),
              title: 'Debit card',
              subTitle: '3566 **** **** 0505',
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
            Row(
              children: [
                Checkbox(value: true, onChanged: (v){

                }),
                Text('Save card details for future payments',style: Styles.textStyle16.copyWith(color: AppColors.greyColor),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
