import 'package:caffeine/features/home/widgets/slider_component.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CursoulSliderOptions extends StatelessWidget {
  const CursoulSliderOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
                      items: [
                        SliderComponent(),
                        SliderComponent(),
                        SliderComponent(),
                        SliderComponent(),
                      ],
                      options: CarouselOptions(
                        height: 140.h,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        padEnds: false,
                        autoPlayCurve: Curves.linearToEaseOut,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 900),
                        viewportFraction: 1,
                      ),
                    );
     
    
    
  }
}