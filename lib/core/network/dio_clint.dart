import 'package:caffeine/core/helpers/pref_helpers.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://gaogtmhoavbrmblbbfwi.supabase.co/rest/v1/',
      headers: {
        'apikey': 'sb_publishable_Zp5LKSmo_HGGYclqzzbObg_SLKfKYDO',
        'Content-Type': 'application/json',
      },
    ),
  );

  DioClient() {
    final _pref = getIt<PrefHelpers>();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _pref.getToken();

          options.headers['Authorization'] = 'Bearer $token';

          print('➡️ Request to: ${options.uri}');
          print('Headers: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ Response ${response.statusCode} from ${response.realUri}');
          print('Headers: ${response.headers}');
          return handler.next(response);
        },
        onError: (e, handler) {
          print('❌ Error: ${e.message}');
          print('Response: ${e.response}');
          return handler.next(e);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
