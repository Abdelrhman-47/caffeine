import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/features/details/data/details_model.dart';

abstract class DetailsRepo {
  Future<PriceModel> getPrice(String size,int productId);

}
class DetailsRepoImpl implements DetailsRepo {
 final ApiServices _apiServices;
  DetailsRepoImpl({required ApiServices apiServices}) : _apiServices = apiServices;

  @override
  Future<PriceModel> getPrice(String size,int productId)async {
    final response=await _apiServices.get('product_sizes?select=real_price&product_id=eq.$productId&size=eq.$size');
    return PriceModel.fromJson(response[0]);
    
  }
}
