import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/shared/custom_button.dart';
import 'package:hungry/features/orderHistory/data/models/Order_details.dart';
import 'package:hungry/features/orderHistory/data/repos/order_history_repo.dart';

import '../../../core/constants/app_styles.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  final OrderHistoryRepo repo = OrderHistoryRepo();
  List<OrderDetails> orders = [];
  bool isLoading = true;

  Future<void> loadOrders() async {
    orders = await repo.getOrderHistory();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    loadOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await loadOrders(),
      color: AppColors.primary,
      backgroundColor: Colors.white,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
            : orders.isEmpty
            ? const Center(child: Text("No previous orders ❌"))
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 120, top: 30),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final orderData = orders[index].data;
              final firstItem = orderData?.items?.first;

              return Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            firstItem?.image ?? "",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(firstItem?.name ?? "",
                                  style: Styles.boldTextStyle16),
                              Text("Qty: X${firstItem?.quantity ?? 1}"),
                              Text("Total: \$${orderData?.totalPrice ?? ""}"),
                            ],
                          )
                        ],
                      ),
                      const Gap(20),
                      CustomButton(
                        text: "Order Again",
                        width: double.infinity,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
