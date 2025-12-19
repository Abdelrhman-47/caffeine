import 'package:caffeine/features/home/cubits/offers_cubit/offers_cubit.dart';
import 'package:caffeine/features/home/cubits/offers_cubit/offers_state.dart';
import 'package:caffeine/features/home/cubits/product_cubit.dart';
import 'package:caffeine/features/home/cubits/product_state.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:caffeine/features/home/widgets/slider_component.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CursoulSliderOptions extends StatelessWidget {
  const CursoulSliderOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(
      builder: ( context, state) {
      if(state is OffertLoading ){
        return SizedBox.shrink();
      }
      if (state is OfferFailure){
    return Center(child: Text(state.errMessage),);  }
    if(state is OfferSuccess){
      final List<OfferModel> offers=state.offers;
      
       return CarouselSlider.builder(
        
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
                        )
                        , itemCount: offers.length, 
                        itemBuilder: (BuildContext context, int index, int realIndex) {  
                          return SliderComponent(offer: offers[index],);
                        },
                      ); 
    }
      
    return SizedBox.shrink();

  }    
    
    
    );
  }
}