import 'package:adopt_a_pet/enum/http_method.dart';

abstract class RequestService {
  Future<dynamic> sendAsync({
    required HttpMethod method,
    required String url,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    String? dataJson = null,
  });
}
