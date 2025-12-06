import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/presentation/manager/cubits/product_cubit/product_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';
import '../widgets/card_item.dart';
import '../widgets/categories.dart';
import '../widgets/search_field.dart';
import '../widgets/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List category = ['All', 'Combos', 'Sliders', 'Classic'];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final authCubit = context.read<AuthCubit>();
    final productCubit = context.read<ProductCubit>();

    if (!authCubit.isGuest) authCubit.getProfileData();
    productCubit.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        if (!authCubit.isGuest) await authCubit.getProfileData();
        await context.read<ProductCubit>().getProducts();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            /// ---------------- HEADER ----------------
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              toolbarHeight: 165,
              automaticallyImplyLeading: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                child: Column(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final isGuest = authCubit.isGuest;
                        final user = authCubit.currentUser;

                        return Skeletonizer(
                          enabled: !isGuest && user == null,
                          child: UserHeader(
                            name: user?.name ?? 'Guest',
                            profileImage: user?.image,
                          ),
                        );
                      },
                    ),

                    const Gap(20),

                    SearchField(
                      controller: searchController,
                      onChanged: (value) {
                        context.read<ProductCubit>().filterProducts(value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// ---------------- CATEGORIES ----------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16,
                ),
                child: Categories(category: category, selectedIndex: 0),
              ),
            ),

            /// ---------------- PRODUCTS GRID ----------------
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                bool loading = state is ProductLoading;
                List<ProductModel> products = [];

                if (state is ProductSuccess) {
                  products = state.productModel;
                } else if (state is ProductFiltered) {
                  products = state.filteredProducts;
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: loading ? 6 : products.length,
                      (context, index) {
                        final product = loading
                            ? ProductModel(
                                image: 'https://via.placeholder.com/150',
                                name: '',
                                desc: '',
                                rating: '',
                                id: '',
                                price: '',
                              )
                            : products[index];

                        return GestureDetector(
                          onTap: loading
                              ? null
                              : () => GoRouter.of(context).push(
                                  AppRoutePaths.productDetailsView,
                                  extra: product,
                                ),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .66,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
