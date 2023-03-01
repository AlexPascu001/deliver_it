import 'package:deliver_it/controllers/popular_product_controller.dart';
import 'package:deliver_it/widgets/app_icon.dart';
import 'package:deliver_it/widgets/big_text.dart';
import 'package:deliver_it/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.getHomeRoute()),
                    // onTap: () => Navigator.pop(context),
                    // onTap: () {
                    //   Get.back();
                    // },
                    child: AppIcon(icon: Icons.clear)
                ),
                GetBuilder<PopularProductController>(builder: (controller) => Stack(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => CartPage()),
                          // onTap: () => Get.toNamed(RouteHelper.getCartRoute()),
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                // color: Colors.white,
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)
                  )
                ),
                // color: Colors.white,
                child: Center(child: BigText(text: product.name!, size: Dimensions.fontSize26,))
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.backgroundColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableText(text: product.description!,),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: Dimensions.width20 * 2.5, right: Dimensions.width20 * 2.5, top: Dimensions.height10, bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => controller.setQuantity(false),
                    child: AppIcon(icon: Icons.remove, backgroundColor: AppColors.primaryColor, iconColor: Colors.white, iconSize: Dimensions.iconSize24,)
                ),
                BigText(text: product.price.toString() + " lei x " + controller.inCartItems.toString(), size: Dimensions.fontSize26 * 1.2,),
                GestureDetector(
                    onTap: () => controller.setQuantity(true),
                    child: AppIcon(icon: Icons.add, backgroundColor: AppColors.primaryColor, iconColor: Colors.white, iconSize: Dimensions.iconSize24,)
                ),
              ],
            ),
          ),
          Container(
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
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10 * 2),
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20)
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      // size: Dimensions.iconSize24,
                    )
                ),
                GestureDetector(
                  onTap: () => controller.addToCart(product),
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20)
                      ),
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10 * 1.5),
                      child: Row(
                        children: [
                          Icon(Icons.shopping_cart_outlined, color: Colors.white, size: Dimensions.iconSize24),
                          SizedBox(width: Dimensions.width10),
                          BigText(text: "Add to cart", color: Colors.white, size: Dimensions.fontSize26,),
                        ],
                      )
                  ),
                )
              ],
            ),
          )
        ],
      ),),
    );
  }
}
