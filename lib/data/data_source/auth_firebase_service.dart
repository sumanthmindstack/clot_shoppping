import 'package:clot_store/domain/entities/app_error.dart';
import 'package:clot_store/domain/entities/params/signup_params.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthFirebaseService {
  Future<Either<AppError, void>> signUp(SignupParams params);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either<AppError, void>> signUp(SignupParams params) async {
    try {
      var returnData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: params.email!, password: params.password!);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(returnData.user!.uid)
          .set({
        'firstName': params.firstName,
        'lastName': params.lastName,
        'email': params.email,
        'password': params.password,
        'gender': params.gender,
      });
      return const Right("Signup was Successfull");
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      return Left(AppError(AppErrorType.api));
    }
  }
}
