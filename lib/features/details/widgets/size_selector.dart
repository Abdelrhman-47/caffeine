

import 'package:caffeine/features/details/widgets/sized_button.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final int selectedIndex;
  final ValueChanged<int> onSizeSelected;

  const SizeSelector({
    required this.sizes,
    required this.selectedIndex,
    required this.onSizeSelected,
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
          onTap: () => onSizeSelected(index),
        ),
      ),
    );
  }
}