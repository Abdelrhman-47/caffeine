

import 'package:caffeine/features/details/cubit/real_price_cubit.dart';
import 'package:caffeine/features/details/widgets/sized_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final int selectedIndex;
  final ValueChanged<int> onSizeSelected;
  final int productInt;


  const SizeSelector({
    required this.sizes,
    required this.selectedIndex,
    required this.onSizeSelected, required this.productInt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        sizes.length,
        (index) => SizeButton(
        
          label: sizes[index],
          isSelected: selectedIndex == index,
          onTap: () {
onSizeSelected(index);
             context.read<RealPriceCubit>().getPrice(sizes[index], productInt);
             
          }
           ,
        
        ),
      ),
    );
  }
}