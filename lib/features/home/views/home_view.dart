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

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../core/utils/custom_snack_bar.dart';
import '../../auth/data/model/user_model.dart';
import '../../auth/data/repos/auth_repo.dart';
import '../widgets/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combos', 'Sliders', 'Classic'];
  final TextEditingController searchController = TextEditingController();
  List<ProductModel>? allProducts;
  int selectedIndex = 0;
  List<ProductModel>? products;
  ProductRepo productRepo = ProductRepo();
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      if (!mounted) return;
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errMessage = 'Error in profile';
      if (e is ApiError) {
        errMessage = e.message;
      }
      if (!mounted) return;
      AppSnackBar.showError(context, errMessage);
    }
  }

  Future<void> getProducts() async {
    final response = await productRepo.getProducts();
    if (!mounted) return;
    setState(() {
      allProducts = response;
      products = response;
    });
  }

  @override
  void initState() {
    getProducts();
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = products == null;

    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppColors.primary,
      onRefresh: () async {
        await getProfileData();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                elevation: 0,
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0,
                toolbarHeight: 165,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                  child: Column(
                    children: [
                      UserHeader(
                        name: userModel?.name ?? 'Guest',
                        profileImage: userModel?.image,
                      ),
                      Gap(20),
                      SearchField(
                        controller: searchController,
                        onChanged: (value) {
                          final query = value.toLowerCase();
                          setState(() {
                            products = allProducts
                                ?.where(
                                  (p) => p.name.toLowerCase().contains(query),
                                )
                                .toList();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16,
                  ),
                  child: Categories(
                    category: category,
                    selectedIndex: selectedIndex,
                  ),
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
                              image:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuutX8HduKl2eiBeqSWo1VdXcOS9UxzsKhQ&s',
                              name: '',
                              desc: '',
                              rating: '',
                              id: '',
                              price: '',
                            )
                          : products![index];

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
      ),
    );
  }
}
