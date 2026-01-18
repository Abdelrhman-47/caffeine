import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key, required this.totalPrice});
 final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
                                  backgroundColor: AppColors.primaryColor,
                                  text: "Pay Now",
                                  onPressed: () async {
                                    await FlutterPaymob.instance.payWithCard(
                                      title: Text(
                                        "Card Payment",
                                      ), // Optional - Custom title AppBar
                                      appBarColor: Colors
                                          .blueAccent, // Optional - Custom AppBar color
                                      context: context,
                                      currency: "EGP",
                                      amount: totalPrice,
                                      onPayment: (response) {
                                        if (response.success) {
                                          print(
                                            "🎉 Payment Success! TxID: ${response.transactionID}",
                                          );
                                        } else {
                                          print(
                                            "❌ Payment Failed: ${response.message}",
                                          );
                                        }
                                      },
                                    );
                                  },
                                  textColor: Colors.white,
                                  height: 40.h,
                                  width: 110.w,
                                  borderRadius: BorderRadius.circular(12.r),
                                  outLineButton: false,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                );
  }
}