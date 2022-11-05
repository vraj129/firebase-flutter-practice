import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function()? onTap;
  final dynamic text;
  final String? image;
  final double? width;
  final double? fsize;
  final FontWeight? fontWeight;
  final Color concolor;
  final Color bordercolor;
  final Color textcolor;

  const AppButton({
    Key? key,
    this.onTap,
    this.text,
    this.width,
    this.image,
    this.fsize,
    this.fontWeight = FontWeight.w600,
    this.concolor = const Color(0xffFDF100),
    this.bordercolor =  const Color(0xff000000),
    required this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        decoration: BoxDecoration(
          color: concolor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: bordercolor,
            width: 1,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fsize ?? 20,
            color: textcolor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}