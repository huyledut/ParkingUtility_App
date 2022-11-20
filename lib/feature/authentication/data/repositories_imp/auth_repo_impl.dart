import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/feature/authentication/data/providers/remote/request/username_password_request.dart';

import '../../domain/repositoties/auth_repo.dart';
import '../models/account_model.dart';
import '../providers/remote/auth_api.dart';

class AuthRepoImpl implements AuthRepo {
  final _authAPI = Get.find<AuthAPI>();

  @override
  Future<AccountModel> login(UsernamePasswordRequest request) {
    return _authAPI.login(request);
  }

}
