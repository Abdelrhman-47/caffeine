import 'package:caffeine/core/network/dio_clint.dart';

class ApiServices {
    final DioClient _dioClient;

  ApiServices({required DioClient dioClient}) : _dioClient = dioClient;
    
    Future<dynamic> get(String endPoint)async{
   final response=   await _dioClient.dio.get(endPoint);
   return response.data;
    }
    Future <dynamic> post(String endPoint,Map<String, dynamic> body)async{
      final response =await _dioClient.dio.post(endPoint,data: body);
      return response.data;
    }
    Future <dynamic> patch(String endPoint,Map<String, dynamic> body)async{
      final response =await _dioClient.dio.patch(endPoint,data: body);
      return response.data;
    }
    
    
    }

