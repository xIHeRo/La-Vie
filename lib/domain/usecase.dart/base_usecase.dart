import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure, Output>> excute(Input input);
}
