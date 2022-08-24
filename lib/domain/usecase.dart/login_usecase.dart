import 'package:la_vie/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:la_vie/domain/models/models.dart';

import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

// Input : LoginUseCase (email, password )
// output : Authontication
// excute : on Input
// return Failure - OR - Autontication

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authontication> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authontication>> excute(
      LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
