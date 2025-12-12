import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/utils/service_locator.dart';
import 'package:hungry/features/auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/get_cart_cubit/get_cart_cubit.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/remove_item_from_cart/remove_item_cubit.dart';
import 'package:hungry/features/orderHistory/presentation/manager/order_history_cubit.dart';

import 'features/auth/presentation/views/profile_view.dart';
import 'features/cart/presentation/views/cart_view.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/orderHistory/presentation/views/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late List<Widget> screens;
  int currentIndex = 0;

  @override
  void initState() {
    screens = [HomeView(), CartView(), OrderHistoryView(), ProfileView()];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetCartCubit(getIt())),
        BlocProvider(create: (_) => RemoveItemCubit(getIt())),
        BlocProvider(create: (_) => AuthCubit(getIt())),
        BlocProvider(create: (_) => OrderHistoryCubit(getIt())),
      ],
      child: Builder(
        builder: (context){
          return  Scaffold(
            body: IndexedStack(index: currentIndex, children: screens),

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey.shade700,

                  onTap: (index)  async{
                    if(index == currentIndex) return;
                    setState(() => currentIndex = index);
                    if (index == 1) {
                       context.read<GetCartCubit>().getCartData();
                    }

                  },

                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.cart),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_restaurant_sharp),
                      label: 'History',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.profile_circled),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
