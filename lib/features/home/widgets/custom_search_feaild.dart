import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// // ============================================
// // 🔍 GLASS SEARCH BAR
// // ============================================

// class GlassSearchBar extends StatefulWidget {
//   final String hintText;
//   final ValueChanged<String>? onChanged;
//   final VoidCallback? onSearchTap;
//   final Color? backgroundColor;
//   final Color? textColor;
//   final Color? hintColor;
//   final double? height;

//   const GlassSearchBar({
//     super.key,
//     this.hintText = 'Find your drink...',
//     this.onChanged,
//     this.onSearchTap,
//     this.backgroundColor,
//     this.textColor,
//     this.hintColor,
//     this.height = 55,
//   });

//   @override
//   State<GlassSearchBar> createState() => _GlassSearchBarState();
// }

// class _GlassSearchBarState extends State<GlassSearchBar> {
//   final TextEditingController _controller = TextEditingController();
//   bool _isFocused = false;

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: widget.height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(_isFocused ? 0.15 : 0.08),
//             blurRadius: _isFocused ? 20 : 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(
//             decoration: BoxDecoration(
//               color: widget.backgroundColor ??
//                   Colors.white.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: _isFocused
//                     ? Colors.white.withOpacity(0.3)
//                     : Colors.white.withOpacity(0.1),
//                 width: 1.5,
//               ),
//             ),
//             child: Row(
//               children: [
//                 const SizedBox(width: 16),
//                 Icon(
//                   Icons.search,
//                   color: widget.hintColor ?? Colors.white.withOpacity(0.5),
//                   size: 22,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Focus(
//                     onFocusChange: (focused) {
//                       setState(() {
//                         _isFocused = focused;
//                       });
//                     },
//                     child: TextField(
//                       controller: _controller,
//                       onChanged: widget.onChanged,
//                       style: TextStyle(
//                         color: widget.textColor ?? Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       decoration: InputDecoration(
//                         hintText: widget.hintText,
//                         hintStyle: TextStyle(
//                           color: widget.hintColor ??
//                               Colors.white.withOpacity(0.5),
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.zero,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (_controller.text.isNotEmpty)
//                   IconButton(
//                     icon: Icon(
//                       Icons.clear,
//                       color: widget.hintColor ?? Colors.white.withOpacity(0.5),
//                       size: 20,
//                     ),
//                     onPressed: () {
//                       _controller.clear();
//                       if (widget.onChanged != null) {
//                         widget.onChanged!('');
//                       }
//                     },
//                   )
//                 else
//                   const SizedBox(width: 8),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ============================================
// 🎨 ALTERNATIVE: DARK GLASS SEARCH
// ============================================

class DarkGlassSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final double? height;

  const DarkGlassSearchBar({
    super.key,
    this.hintText = 'Find your coffee...',
    this.onChanged,
    this.height = 55,
  });

  @override
  State<DarkGlassSearchBar> createState() => _DarkGlassSearchBarState();
}

class _DarkGlassSearchBarState extends State<DarkGlassSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: _isFocused ? 20 : 10,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: _isFocused
                      ? Colors.black.withOpacity(0.5)
                      : Colors.grey.shade700.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                   SizedBox(width: 12.w),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 22,
                  ),
                   SizedBox(width: 8.w),
                  Expanded(
                    child: Focus(
                      onFocusChange: (focused) {
                        setState(() {
                          _isFocused = focused;
                        });
                      },
                      child: TextField(
                        controller: _controller,
                        onChanged: widget.onChanged,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey.shade400,
                        size: 16,
                      ),
                      onPressed: () {
                        _controller.clear();
                        if (widget.onChanged != null) {
                          widget.onChanged!('');
                        }
                      },
                    )
                  else
                   SizedBox(width: 8.w),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
