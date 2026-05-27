import 'package:dio/dio.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/models/register_model/register_model.dart';
import '../../../../../core/network/api_endpoint.dart';
import '../../../../../core/network/data/data_state.dart';
import '../../../../../core/network/dio_client.dart';
import '../../models/login_model/login_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<DataState<LoginResponse>> login(LoginParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.login,
        requiresToken: false,
        data: params.toJson(),
      );
        return DataSuccess(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorResponse = ResponseError.fromJson(e.response!.data);
        return DataFailed(errorResponse); // Hết lỗi đỏ!
      }
      return DataFailed(ResponseError(message: 'Mất kết nối mạng',));
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<DataState<LoginResponse>> register(RegisterParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.register,
        requiresToken: false,
        data: params.toJson(),
      );
      return DataSuccess(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorResponse = ResponseError.fromJson(e.response!.data);
        return DataFailed(errorResponse); // Hết lỗi đỏ!
      }
      return DataFailed(ResponseError(message: 'Mất kết nối mạng',));
    } catch (e) {
      throw Exception('$e');
    }
  }
}
