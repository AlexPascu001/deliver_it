import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/popular_food_details.dart';
import '../pages/food/recommended_food_details.dart';
import '../pages/home/main_food_page.dart';

class RouteHelper {
  static const String home = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cart = "/cart-page";

  static String getHomeRoute() => home;
  static String getPopularFoodRoute(int pageId) => "$popularFood?pageId=$pageId";
  static String getRecommendedFoodRoute(int pageId) => "$recommendedFood?pageId=$pageId";
  static String getCartRoute() => cart;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          return PopularFoodDetails(pageId: int.parse(pageId!),);
        },
        transition: Transition.cupertinoDialog,
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          return RecommendedFoodDetails(pageId: int.parse(pageId!),);
        },
        transition: Transition.cupertinoDialog,
    ),
    GetPage(name: cart,
        page: () => CartPage(),
        transition: Transition.cupertinoDialog,
    ),
  ];
}