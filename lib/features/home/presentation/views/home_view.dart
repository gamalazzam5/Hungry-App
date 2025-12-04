import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/repos/product_repo_old_version.dart';
import 'package:hungry/features/home/presentation/manager/cubits/product_cubit/product_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../auth/data/model/user_model.dart';
import '../../../auth/data/repos/old_version_repo.dart';
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
  List category = ['All', 'Combos', 'Sliders', 'Classic'];
  final TextEditingController searchController = TextEditingController();
  List<ProductModel>? allProducts;
  int selectedIndex = 0;
  List<ProductModel>? products;
  ProductRepo productRepo = ProductRepo();
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  late AuthCubit authCubit;
  late ProductCubit productCubit;
  late bool isGuest;

  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.getProducts();
    isGuest = authCubit.isGuest;
    !isGuest? authCubit.getProfileData():null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = products == null;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthProfileData) {
          setState(() {
            userModel = state.user;
          });
        }
      },
      child: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        onRefresh: () async {
          !isGuest? await authCubit.getProfileData():null;
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
                        Skeletonizer(
                          enabled: userModel == null && !isGuest,
                          child: UserHeader(
                            name: userModel?.name ?? 'Guest',
                            profileImage: userModel?.image,
                          ),
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
                  sliver: BlocListener<ProductCubit,ProductState>(
                    listener: (context,state){
                      if(state is ProductSuccess){
                        setState(() {
                          products = state.productModel;
                          allProducts = state.productModel;
                        });
                      }else if(state is ProductLoading){
                        setState(() {
                          loading = true;
                        });
                      }else{
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: loading ? 6 : products!.length,
                        (context, index) {
                          /// here we will make edit
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
