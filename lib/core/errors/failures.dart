import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class ServerFailure extends Failures{}

class CachedFailure extends Failures{}
class NetworkFailure extends Failures{}