import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/core/network/network_cheacker.dart';
import 'package:caffeine/features/details/data/details_model.dart';

abstract class DetailsRepo {
  Future<PriceModel> getPrice(String size,int productId);

}
class DetailsRepoImpl implements DetailsRepo {
    final NetworkChecker _networkChecker;

 final ApiServices _apiServices;
  DetailsRepoImpl({required ApiServices apiServices, required NetworkChecker networkChecker}) : _apiServices = apiServices ,_networkChecker = networkChecker;

  @override
  Future<PriceModel> getPrice(String size,int productId)async {
        final hasInternet = await _networkChecker.isConnected;

    if (!hasInternet) {
  throw Exception('No internet connection');
}
  
    final response=await _apiServices.get('product_sizes?select=real_price&product_id=eq.$productId&size=eq.$size');
    return PriceModel.fromJson(response[0]);
    
  }
}
