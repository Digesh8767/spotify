import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositotyImpl extends AuthRepository {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    return await sl<AuthFirebaseService>().signup(createUserRequest);
  }
}
