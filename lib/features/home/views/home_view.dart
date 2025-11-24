import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import 'package:hungry/features/home/widgets/card_item.dart';
import 'package:hungry/features/home/widgets/categories.dart';
import 'package:hungry/features/home/widgets/search_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combos', 'Sliders', 'Classic'];
  int selectedIndex = 0;
  List<ProductModel>? products;
  ProductRepo productRepo = ProductRepo();

  Future<void> getProducts() async {
    final response = await productRepo.getProducts();
    setState(() {
      products = response;
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = products == null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 165,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: Column(children: [UserHeader(), Gap(20), SearchField()]),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Categories(category: category, selectedIndex: selectedIndex),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: loading ? 6 : products!.length,
                      (context, index) {
                    final product = loading
                        ? ProductModel(
                      //fake image
                      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuutX8HduKl2eiBeqSWo1VdXcOS9UxzsKhQ&s',
                      name: '',
                      desc: '',
                      rating: '',
                      id: '',
                      price: ''
                    )
                        : products![index];

                    return GestureDetector(
                      onTap: loading
                          ? null
                          : () => GoRouter.of(context)
                          .push(AppRoutePaths.productDetailsView,extra: product),

                      child: Skeletonizer(
                        enabled: loading,
                        child: CardItem(
                          image: product.image,
                          text: product.name,
                          desc: product.desc,
                          rate: product.rating,
                          isSelected: false,
                        ),
                      ),
                    );
                  },
                ),
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
