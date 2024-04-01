import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight? weight;
  final String? family;
  final TextAlign? align;
  final double? spacing;
  final TextDecoration? decoration;
  final int? maxlines;
  final TextOverflow? overFlow;
  final List<Shadow>? shadows;

  final double? size;

  const MyText(
      {Key? key,
      required this.text,
      this.color,
      this.weight,
      this.family,
      this.size,
      this.spacing,
      this.align,
      this.decoration,
      this.overFlow,
      this.maxlines, this.shadows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      maxLines: maxlines,
      style: TextStyle(
          overflow: overFlow ?? TextOverflow.ellipsis,
          decoration: decoration,
          letterSpacing: spacing,
          color: color,
          fontSize: size,
          fontFamily: family,
          fontWeight: weight,
          shadows: shadows,
          ),
    );
  }
}
