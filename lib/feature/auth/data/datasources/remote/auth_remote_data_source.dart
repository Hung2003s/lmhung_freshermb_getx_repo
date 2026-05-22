

import 'package:lmhung_freshermb_getx_repo/feature/auth/data/models/register_model/register_model.dart';

import '../../../../../core/network/data/data_state.dart';
import '../../models/login_model/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<DataState<LoginResponse>> login(LoginParams params);
  Future<DataState<LoginResponse>> register(RegisterParams params);
}