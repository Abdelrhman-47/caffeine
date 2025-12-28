import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterSection extends StatelessWidget {
  const CounterSection({super.key, required this.productId});
  final int productId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.read<CounterCubit>().decrement(productId);
          },
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.primaryColor,
            child: Icon(CupertinoIcons.minus, color: Colors.white, size: 20.sp),
          ),
        ),
        Spacing.hSpace(12.w),
        Text(
          context.watch<CounterCubit>().getCount(productId).toString(),
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        Spacing.hSpace(12.w),
        GestureDetector(
          onTap: () {
            context.read<CounterCubit>().increment(productId);
          },
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.primaryColor,
            child: Icon(CupertinoIcons.add, color: Colors.white, size: 20.sp),
          ),
        ),
      ],
    );
  }
}
