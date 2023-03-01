import 'package:deliver_it/controllers/cart_controller.dart';
import 'package:deliver_it/routes/route_helper.dart';
import 'package:deliver_it/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';
import '../cart/cart_page.dart';
import '../home/main_food_page.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageId;
  PopularFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: Stack(
        children: [
          // background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                    ),
                    fit: BoxFit.cover
                  )
                ),

              )
          ),
          // back button and cart icon
          Positioned(
              top: Dimensions.height50,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    // onTap: () => Navigator.pop(context),
                    onTap: () => Get.toNamed(RouteHelper.getHomeRoute()),
                    // onTap: () {
                    //   Get.to(() => MainFoodPage());
                    // },
                      child: AppIcon(icon: Icons.arrow_back_ios)
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) => Stack(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.getCartRoute()),
                        // onTap: () => Get.to(() => CartPage()),
                          child: AppIcon(icon: Icons.shopping_cart_outlined, iconSize: Dimensions.iconSize24)
                      ),
                      Get.find<PopularProductController>().totalItems > 0 ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: Dimensions.width20,
                          height: Dimensions.height20,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius10)
                          ),
                          child: Center(child: SmallText(text: Get.find<PopularProductController>().totalItems.toString(), color: Colors.white,)),
                        ),
                      ) : SizedBox()
                    ]
                  ),)
                ],
              )
          ),
          // food details
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - Dimensions.height20,
            child: Container(
              padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20), topRight: Radius.circular(Dimensions.radius20))
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!, price: product.price?.toDouble()),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: "Description", size: Dimensions.fontSize26),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: product.description!
                        ),
                      ),
                    )
                  ],
                ),
            )
          )
        ]
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct) => Container(
        height: Dimensions.listViewImgSize,
        padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20 * 2), topRight: Radius.circular(Dimensions.radius20 * 2))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20)
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () => popularProduct.setQuantity(false),
                        child: Icon(Icons.remove, color: Colors.white, size: Dimensions.iconSize24)
                    ),
                    SizedBox(width: Dimensions.width5),
                    BigText(text: popularProduct.inCartItems.toString(), color: Colors.white, size: Dimensions.fontSize26),
                    SizedBox(width: Dimensions.width5),
                    GestureDetector(
                        onTap: () => popularProduct.setQuantity(true),
                        child: Icon(Icons.add, color: Colors.white, size: Dimensions.iconSize24)
                    ),
                  ],
                )
            ),
            GestureDetector(
              onTap: () => popularProduct.addToCart(product),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20)
                  ),
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart_outlined, color: Colors.white, size: Dimensions.iconSize24),
                      SizedBox(width: Dimensions.width10),
                      BigText(text: "Add to cart", color: Colors.white, size: Dimensions.fontSize26),
                    ],
                  )
              ),
            )
          ],
        ),
      ),),
    );
  }
}
