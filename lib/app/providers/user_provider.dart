import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/user_model.dart';

class UserProvider {
  static Future<Either<Map<String, dynamic>?, String?>> login(
      String mobile, String password) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/LoginCustomer',
        data: {
          "params": {
            "mobile": mobile,
            "password": password,
          }
        },
      );

      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final user = User.fromJson(result['customer']);
        List<ClassModel> availableClasses = [];
        Map<String, dynamic> returnedResponse = {};
        availableClasses = (result['available_class'] as List).map((e) => ClassModel.fromMap(e)).toList();
        if (user.userType == 'T'){
          returnedResponse['teacher_subjects'] = result['teacher_subjects'];
          availableClasses = (result['available_class'] as List).map((e) => ClassModel.fromMap(e)).toList();
        }
        returnedResponse['user'] = user;
        returnedResponse['available_class'] = availableClasses;
        return left(returnedResponse);
      } else {
        return right(result['msg']);
      }
    } on DioError catch (e) {
      return right(e.message);
    } on Exception catch (e) {
      return right(e.toString());
    }
  }

  static Future<Either<bool, String?>> updateToken(
      int userId, String? token) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/updatetoken',
        data: {
          "params": {"customer_id": userId, "token": token}
        },
      );

      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['msg']);
      }
    } on DioError catch (e) {
      return right(e.message);
    } on Exception catch (e) {
      return right(e.toString());
    }
  }
}
