import 'package:dartz/dartz.dart';
import 'package:la_vie/data/network/failure.dart';
import 'package:la_vie/data/network/requests.dart';
import 'package:la_vie/domain/models/models.dart';

abstract class Repository {
  Future<Either<Failure, Authontication>> login(LoginRequest loginRequest);
}
