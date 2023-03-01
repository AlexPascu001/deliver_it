import 'package:deliver_it/routes/route_helper.dart';
import 'package:deliver_it/widgets/app_icon.dart';
import 'package:deliver_it/widgets/big_text.dart';
import 'package:deliver_it/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.primaryColor,
                      iconSize: Dimensions.iconSize16 * 1.2,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20 * 4,),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.getHomeRoute()),
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.primaryColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
            )
          ),
          Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var cartList = cartController.cartList;
                    return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (_, index) => Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 5,
                      child: Row(
                          children: [
                            Container(
                              width: Dimensions.width20 * 5,
                              height: Dimensions.height20 * 5,
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.cartList[index].img!
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            SizedBox(width: Dimensions.height10,),
                            Expanded(child: Container(
                              height: Dimensions.height20 * 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(text: cartController.cartList[index].name!),
                                  SmallText(text: "Spicy"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(text: "${cartController.cartList[index].price?.toDouble()} lei"),
                                      Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              color: AppColors.secondaryColor,
                                              borderRadius: BorderRadius.circular(Dimensions.radius20)
                                          ),
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                // onTap: () => popularProduct.setQuantity(false),
                                                  child: Icon(Icons.remove, color: Colors.white, size: Dimensions.iconSize24)
                                              ),
                                              SizedBox(width: Dimensions.width5),
                                              BigText(text: cartList[index].quantity.toString(), color: Colors.white,),
                                              SizedBox(width: Dimensions.width5),
                                              GestureDetector(
                                                // onTap: () => popularProduct.setQuantity(true),
                                                  child: Icon(Icons.add, color: Colors.white, size: Dimensions.iconSize24)
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))

                          ]
                      ),
                    ),
                  );
                  }
                  ),
                )
                ),
              )
        ],
      )
    );
  }
}
