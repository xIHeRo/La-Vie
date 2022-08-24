import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:la_vie/app/constants.dart';
import 'package:la_vie/data/responses/response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(Constants.customersLogin)
  Future<AuthonticationResponse> login(
      @Field("email") String email, @Field("password") String password);
}
