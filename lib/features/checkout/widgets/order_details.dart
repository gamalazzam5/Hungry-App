import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import 'order_summary.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order, required this.taxes, required this.fees, required this.total});
final String order,taxes,fees,total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderSummary(title: 'Order', price: order),
        OrderSummary(title: 'Taxes', price: taxes),
        OrderSummary(title: 'Delivery fees', price: fees),
        const Divider(color: AppColors.greyColor,thickness: .5,endIndent: 20,indent: 20,),
        const Gap(20),
         OrderSummary(title: 'Total', price: total,isBold: true),
        const Gap(16),
        OrderSummary(title:"Estimated delivery time:" , price: '15 - 30 mins',isBold: true,
          isSmall: true,),
      ],
    );
  }
}
