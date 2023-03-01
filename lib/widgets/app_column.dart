import 'package:deliver_it/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double? price;
  const AppColumn({Key? key, required this.text, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: BigText(text: text, size: Dimensions.fontSize26)),
            price.isNull
                ? SizedBox()
                :
            Flexible(child: BigText(text: price.toString() + " lei", size: Dimensions.fontSize26))
          ],
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(Icons.star,
                      color: AppColors.primaryColor, size: Dimensions.fontSize15)),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(
                text: "4.5",
                color: AppColors.primaryColor,
                size: Dimensions.fontSize15),
            SizedBox(width: Dimensions.width10),
            SmallText(
                text: "120 reviews",
                color: AppColors.secondaryColor,
                size: Dimensions.fontSize15),
            // SizedBox(width: 10),
            // SmallText(text: "comments", color: AppColors.secondaryColor, size: 15),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndText(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.primaryColor),
            IconAndText(
                icon: Icons.access_time_rounded,
                text: "25min",
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
