import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/shared/custom_button.dart';

import '../../../core/constants/app_styles.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

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
    itemCount: 3,
    itemBuilder: (context, index) {
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
                      Image.asset('assets/test/image 6.png', height: 102, width: 110),

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
