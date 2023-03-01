import 'package:deliver_it/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';
class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    // print("Getting popular product list");
    Response response = await recommendedProductRepo.getRecommendedProductList();
    //print("Response: ${response.statusCode}");
    if (response.statusCode == 200) {

      print("Success! got recommended product list");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    }
    else {
      print("Error: Could not get recommended product list");
    }
  }
}