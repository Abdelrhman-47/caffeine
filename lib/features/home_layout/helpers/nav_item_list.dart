import 'package:caffeine/features/home_layout/widgets/glass_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavItemList{
  static final List <UltraNavItem> items=[
        UltraNavItem(
                            icon: Icon(CupertinoIcons.home,size: 15.sp,color: Colors.white),
                            label: 'Home',
                            activeIcon: Icon(CupertinoIcons.home,size: 17.sp,color: Colors.white),
                          ),
                          UltraNavItem(
                            icon: Icon(CupertinoIcons.cart,size: 15.sp,color: Colors.white,),
                            label: 'cart',
                            activeIcon:  Icon(CupertinoIcons.cart,size: 17.sp,color: Colors.white,),
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