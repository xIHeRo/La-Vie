import 'package:la_vie/data/network/app_api.dart';
import 'package:la_vie/data/network/requests.dart';
import 'package:la_vie/data/responses/response.dart';

abstract class RemoteDataSource {
  // when we send the email and pass it returns the data information as AuthResponse
  Future<AuthonticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthonticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
