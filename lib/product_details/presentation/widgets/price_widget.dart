import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_scraping_task/product_details/domain/entities/product.dart';

import '../../../core/utils/app_colors.dart';

class PriceWidget extends StatelessWidget {
  final Price price;
  const PriceWidget({required this.price,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.textBlack,
          ),
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: NetworkImage(price.image),
            // fit: BoxFit.fill,
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
             price.name,
              style:
              Theme.of(context).textTheme.bodyText1),
          // const SizedBox(width: 10),
          Icon(
            price.stock
                ? Icons.check_circle
                : Icons.cancel,
            size: 15.sp,
            color: price.stock
                ? Colors.green
                : Colors.red,
          )
        ],
      ),
      trailing: Text(
          '${price.price.toString()} EGP',
          style:
          Theme.of(context).textTheme.bodyText1),
    );
  }
}
