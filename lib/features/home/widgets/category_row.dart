import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryRow extends StatefulWidget {
  CategoryRow({super.key});
  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  final List<String> category = [
    'All drinks',
    'hot',
    'fresh drinks',
    'ice coffie',
    'others',
  ];
int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(category.length, (index) {
                      bool isSelected = selectedIndex == index; 

            return Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: Row(
                children: [
                  GestureDetector(onTap: (){
                    setState(() {
                      selectedIndex=index;
                    });
 if (index == 0) {
      context.read<ProductCubit>().getAllProducts();
    } else {
      context.read<ProductCubit>().ProductsByCategory(index); 
    }                  },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      height: 35.h,
                      width: 90.w,
                      decoration:
                       BoxDecoration(
                        border: Border.all(color:isSelected==false? AppColors.primaryColor: Colors.transparent ),
                        borderRadius: BorderRadius.circular(15.r),
                        color:isSelected==true? AppColors.primaryColor: Colors.white,
                      ),
                      child: Text(
                        category[index],
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color:isSelected==true? Colors.white:AppColors.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Spacing.hSpace(1.w),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}