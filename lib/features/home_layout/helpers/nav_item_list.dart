import 'package:caffeine/features/home_layout/widgets/glass_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavItemList{
  static final List <UltraNavItem> items=[
        UltraNavItem(
                            icon: SvgPicture.asset(
                              'assets/svgs/house-regular-full.svg',
                              color: Colors.white,
                              width: 16.w,
                            ),
                            label: 'Home',
                            activeIcon: SvgPicture.asset(
                              'assets/svgs/house-regular-full.svg',
                              color: Colors.white,
                              width: 20.w,
                            ),
                          ),
                          UltraNavItem(
                            icon: SvgPicture.asset(
                              'assets/svgs/basket-shopping-solid-full.svg',
                              color: Colors.white,
                              width: 16.w,
                            ),
                            label: 'cart',
                            activeIcon: SvgPicture.asset(
                              'assets/svgs/basket-shopping-solid-full.svg',
                              color: Colors.white,
                              width: 20.w,
                            ),
                          ),
                          UltraNavItem(
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            label: 'favorites',
                            activeIcon: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                          UltraNavItem(
                            icon: SvgPicture.asset(
                              'assets/svgs/user-regular-full.svg',
                              color: Colors.white,
                              width: 16.w,
                            ),
                            label: 'profile',
                            activeIcon: SvgPicture.asset(
                              'assets/svgs/user-regular-full.svg',
                              color: Colors.white,
                              width: 20.w,
                            ),
                          ),
  ];
}