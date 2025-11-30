import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/features/orderHistory/data/repos/order_history_repo.dart';

import '../../../core/constants/app_styles.dart';
import '../data/models/order_history.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  OrderHistoryRepo orderHistoryRepo = OrderHistoryRepo();
  List<OrderHistory> orders = [];
  Future<void> getOrderHistory()async {
    try{
       orders = await orderHistoryRepo.getOrderHistory();
       setState(() {});

    }catch(e){
         print(e.toString());
    }

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
    itemCount: orders.length,
    itemBuilder: (context, index) {
      final order = orders[index];
      return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Image.network(order.image, height: 102, width: 110),

                    ],
                  ),
                  Column(
                    children: [
                      Text('Hamburger', style: Styles.boldTextStyle16),
                      Text('Quantity: X3', style: Styles.textStyle16),
                      Text('Price: \$10', style: Styles.textStyle16),

                    ],
                  )
                ],
              ),
              Gap(20),
              CustomButton(text: 'Order Again',width: double.infinity,

              color: Colors.grey.shade400,)
            ],
          ),
        ),
      );
    },
  ),
),
    );
  }
}
