import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FondoSvg extends StatelessWidget {

  const FondoSvg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebsafeSvg.asset("assets/icons/bg.svg", fit: BoxFit.fill);
  }
}