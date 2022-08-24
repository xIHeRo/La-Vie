import 'package:dartz/dartz.dart';
import 'package:la_vie/data/mapper/mapper.dart';
import 'package:la_vie/domain/models/models.dart';

import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/requests.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authontication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        print("start trying");
        // its connected to internet, its safe to call API
        final authResponse = await _remoteDataSource.login(loginRequest);
        print(authResponse.type);
        //print("Look here ::${authResponse.status}");
        // check the connection with api is success of not
        if (authResponse.type == ApiInternalStatues.successType) {
          print("Enter SUCCESS");
          // success -> return  right -> data
          return Right(authResponse.toDomain());
        } else {
          print("Enter FAILURE");
          // failure --return left-> business error
          return Left(Failure(ApiInternalStatues.FAILURE,
              authResponse.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print("Enter catch error : ");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      print("Enter No internet");
      // return internet connection error --> Left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
