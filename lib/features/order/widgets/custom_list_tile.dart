import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.paymentName,
    required this.tileColor,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.showSubtitle,
  });

  final String paymentName;
  final Color tileColor;
  final String value;
  final String groupValue;
  final bool showSubtitle;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: tileColor,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      leading:
          const Icon(CupertinoIcons.creditcard, color: Colors.white),
      title: Text(
        paymentName,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: showSubtitle
          ? const Text(
              '**** ***** ****',
              style: TextStyle(color: Colors.white),
            )
          : const SizedBox.shrink(),
      trailing: Radio<String>(
        activeColor: Colors.white,
        value: value,
        groupValue: groupValue,
        onChanged: (v) => onChanged(v!),
      ),
      onTap: () => onChanged(value),
    );
  }
}
