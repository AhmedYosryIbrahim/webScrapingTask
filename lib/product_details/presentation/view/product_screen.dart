import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_scraping_task/core/utils/app_strings.dart';
import 'package:web_scraping_task/product_details/presentation/cubit/product_cubit.dart';
import 'package:web_scraping_task/product_details/presentation/cubit/product_cubit.dart';
import 'package:web_scraping_task/product_details/presentation/widgets/price_widget.dart';

import '../../../core/utils/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String productName = 'Apple AirPods Pro 2';
  List<String> productTags = [];
  bool showAll = false;

  @override
  void initState() {
    // TODO: implement initState
    context.read<ProductCubit>().getProductDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarTitle),
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ProductLoaded) {
            productTags = state.product.title.split(' ').toList();
            context.read<ProductCubit>().getAmazonPrice();
            context.read<ProductCubit>().getDpPrice();
            context.read<ProductCubit>().getJumiaPrice();
          }
          if (state is ProductError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return state is ProductLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 10.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        context.read<ProductCubit>().product.image,
                        width: double.infinity,
                        height: 250.h,
                      ),
                      Text(
                        context.read<ProductCubit>().product.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      // sprarate product name in tags and show them in a row
                      SizedBox(
                        height: 50.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              label: Text(productTags[index],
                                  style: Theme.of(context).textTheme.bodyText2),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 10.w);
                          },
                          itemCount: productTags.length,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(AppStrings.compareTitle,
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 20.h),
                      // show list of websites to compare prices
                      state is PriceLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return PriceWidget(
                                    price: context
                                        .read<ProductCubit>()
                                        .priceList[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10.h);
                              },
                              itemCount: showAll
                                  ? context
                                      .read<ProductCubit>()
                                      .priceList
                                      .length
                                  : context
                                              .read<ProductCubit>()
                                              .priceList
                                              .length >=
                                          2
                                      ? 2
                                      : 1,
                            ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                showAll = !showAll;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    showAll
                                        ? 'Show all prices'
                                        : 'Show less prices',
                                    style:
                                        Theme.of(context).textTheme.bodyText1!),
                                Icon(
                                    showAll
                                        ? Icons.keyboard_arrow_up_outlined
                                        : Icons.keyboard_arrow_down_outlined,
                                    color: AppColors.primaryColor)
                              ],
                            )),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
