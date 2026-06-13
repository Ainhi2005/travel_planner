import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    print('Testing connection to mockHomes...');
    final response = await dio.get('http://127.0.0.1:3658/m1/1299251-1298517-default/api/home');
    print('SUCCESS: ' + response.statusCode.toString());
    print(response.data);
  } on DioException catch (e) {
    print('ERROR TYPE: ' + e.type.toString());
    print('ERROR INNER: ' + e.error.toString());
  } catch (e) {
    print('UNKNOWN ERROR: ' + e.toString());
  }
}
