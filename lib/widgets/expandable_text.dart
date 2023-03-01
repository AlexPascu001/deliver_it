import 'package:deliver_it/utils/colors.dart';
import 'package:deliver_it/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstPart;
  late String secondPart;
  bool hidden = true;
  double textHeight = Dimensions.expandedTextSize;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstPart = widget.text.substring(0, textHeight.toInt());
      secondPart = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstPart = widget.text;
      secondPart = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondPart.isEmpty ? SmallText(text: firstPart) : Column(
        children: [
          SmallText(height: 1.7, text: hidden ? firstPart + "..." : widget.text, color: AppColors.secondaryColor,),
          InkWell(
            onTap: () {
              setState(() {
                hidden = !hidden;
              });
            },
            child: Row(
              children: [
                SmallText(text: hidden ? "Show more" : "Show less", color: AppColors.primaryColor),
                Icon(hidden ? Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.primaryColor)
              ],
            ),
          )
        ]
      )
    );
  }
}
