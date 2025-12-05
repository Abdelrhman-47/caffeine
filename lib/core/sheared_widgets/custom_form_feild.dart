import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTxtfield extends StatefulWidget {
  const CustomTxtfield({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller, required this.validator,
  });
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
final String? Function(String?) validator;

  @override
  State<CustomTxtfield> createState() => _CustomTxtfieldState();
}

class _CustomTxtfieldState extends State<CustomTxtfield> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 11.h,
      style: TextStyle(fontSize: 12.sp, color: Colors.white.withOpacity(.7)),
      controller: widget.controller,
      cursorColor: Colors.white,
      validator:widget.validator ,
      obscureText: _obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 13.h),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _togglePassword,
                child: Icon(
                  CupertinoIcons.eye,
                  color: Colors.white,
                  size: 19,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey, width: 0.2.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey, width: 0.1.w),
        ),

        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red,width: .1.w),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
        fillColor: Colors.brown.shade900.withOpacity(.3),
        filled: true,
      ),
    );
  }
}
