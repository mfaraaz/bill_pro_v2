import 'package:bill_pro_v2/constants.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer(
      {this.child, this.width, this.color = kContainerColor, this.padding = 0});
  final Widget child;
  final double width;
  final Color color;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        // boxShadow: [
        //   BoxShadow(
        //     offset: const Offset(5.0, 5.0),
        //     color: Colors.black12,
        //     blurRadius: 4.0,
        //     spreadRadius: .1,
        //   ),
        // ],
      ),
      child: child,
    );
  }
}
