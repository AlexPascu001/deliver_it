import 'package:deliver_it/controllers/popular_product_controller.dart';
import 'package:deliver_it/controllers/recommended_product_controller.dart';
import 'package:deliver_it/pages/food/popular_food_details.dart';
import 'package:deliver_it/routes/route_helper.dart';
import 'package:deliver_it/widgets/big_text.dart';
import 'package:deliver_it/widgets/icon_and_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/small_text.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  double scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
        print("Current page: $currentPageValue");
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded ? Container(
              height: Dimensions.pageView,
              // color: Colors.red, // just for testing
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),
              ) : CircularProgressIndicator(
            color: AppColors.primaryColor,
          );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length,
            position: currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.primaryColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        // Popular text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.grey),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairings", color: Colors.grey),
              )
            ],
          ),
        ),
        // list of food and images
          GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
            return recommendedProduct.isLoaded ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getRecommendedFoodRoute(index));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                        child: Row(
                            children: [
                              // image container
                              Container(
                                width: Dimensions.listViewImgSize,
                                height: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + recommendedProduct.recommendedProductList[index].img!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // text container
                              Expanded(
                                child: Container(
                                  height: Dimensions.listViewTextSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(Dimensions.radius20),
                                        bottomRight: Radius.circular(Dimensions.radius20)
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                        SmallText(text: "With loaded fries and coke"),
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
                                    ),
                                  ),
                                ),
                              )
                            ]
                        )
                    ),
                  );
                }) : CircularProgressIndicator(
              color: AppColors.primaryColor,
            );
          }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currentScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFoodRoute(index));
            },
            child: Container(
                height: Dimensions.pageViewContainer,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: index.isEven
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!),
                        fit: BoxFit.cover))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 5)),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(5, 0),
                      )
                    ]),
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10),
                  child: AppColumn(text: popularProduct.name!, /*price: popularProduct.price!.toDouble()*/),
                )),
          ),
        ],
      ),
    );
  }
}
