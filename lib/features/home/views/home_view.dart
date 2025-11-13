import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/home/widgets/card_item.dart';
import 'package:hungry/features/home/widgets/categories.dart';
import 'package:hungry/features/home/widgets/search_field.dart';

import '../widgets/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combos', 'Sliders', 'Classic'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 160,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 40,right: 20,left: 20),
                child: Column(children: [UserHeader(),Gap(20), SearchField()]),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
                child: Categories(
                  category: category,
                  selectedIndex: selectedIndex,
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: 6, (
                  context,
                  index,
                ) {
                  return CardItem(
                    image: 'assets/test/image 6.png',
                    text: 'Cheeseburger',
                    desc: "Wendy's Burger",
                    rate: "4.9",
                    isSelected: false,
                  );
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .66,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
