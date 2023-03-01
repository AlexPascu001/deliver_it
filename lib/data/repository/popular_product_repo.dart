import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';
class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    // return await apiClient.getData("/api/v1/users/0ae430d2-fe3e-3776-89e9-04e9fde75cdb/favorites");
  }
}