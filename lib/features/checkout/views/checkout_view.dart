import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_styles.dart';
import 'package:hungry/features/checkout/widgets/order_details.dart';
import 'package:hungry/features/checkout/widgets/payment_tile.dart';

import '../../../core/shared/custom_button.dart';

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
        child: SingleChildScrollView(
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
                  Checkbox(
                      activeColor: const Color(0xFFEF2A39),
                      value: true, onChanged: (v){
          
                  }),
                  Text('Save card details for future payments',style: Styles.textStyle14.copyWith(color: AppColors.greyColor),)
                ],
              ),
              Gap(200)
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:   BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: .4),
              spreadRadius: 5,
              blurRadius: 7,

            )
          ]
        ),
        padding: EdgeInsets.all(14),
        height: 90,
        child:  Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text('Total', style: Styles.boldTextStyle20),
                Text('\$18.9', style: Styles.boldTextStyle20),
              ],
            ),
            CustomButton(text: 'Pay now', onTap: () {
              
              showDialog(context: context, builder: (context){
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 180),
                    child: Container(
                      padding:const  EdgeInsets.all(20),
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius:   BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: .4),
                              spreadRadius: 5,
                              blurRadius: 7,

                            )
                          ]
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.primary,
                            child: Icon(CupertinoIcons.check_mark,color: Colors.white,size: 30,),
                          ),
                          Gap(10),
                          Text('Success !',style:Styles.boldTextStyle24.copyWith(color: AppColors.primary,fontSize: 30) ,),
                          Gap(8),
                          Text('Your payment was successful\nA receipt for this purchase has\n been sent to your email.',
                          style: Styles.textStyle12.copyWith(color: Colors.grey.shade500),
                          ),
                        Gap(20),
                          CustomButton(text: "Close",onTap: ()=>context.pop(),width: 200,)
                        ],
                      ),
                    ),
                  ) ,
                );
              });
            },

            horizontalPadding: 20,),
          ],
        ),
      ),
    );
  }
}
