import 'package:deliver_it/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  SmallText({Key? key,
    this.color = const Color(0xff2c3e50),
    required this.text,
    this.size = 0,
    this.height = 1.2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.fontSize12 : size,
        fontFamily: 'Roboto',
        height: height,
      ),
    );
  }
}
