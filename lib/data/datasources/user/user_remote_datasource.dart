import 'dart:convert';

import 'package:yaho_demo/common/path_constants.dart';
import 'package:yaho_demo/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/network_helper.dart';
import '../../models/user/user_model.dart';

abstract class UserRemoteDatasource {
  /// Calls the https://reqres.in/api/users?page={number} endpoint.
  ///
  /// Throws a [ServerException] for 5xx error codes.
  ///
  /// Throws a [ClientNetworkException] for 4xx error codes.
  Future<UserModel> getUserModel({required int page});
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  UserRemoteDatasourceImpl({required this.client});
  final http.Client client;

  @override
  Future<UserModel> getUserModel({required int page}) async {
    return await _getUsersFromApi(PathConstants.apiUrl, page);
  }

  Future<UserModel> _getUsersFromApi(String url, int page) async {
    final response = await client.get(
      Uri.parse("${url}users?page=$page"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == NetworkHelper.successCode) {
      return UserModel.fromJson(json.decode(response.body));
    } else if (NetworkHelper.clientErrorCodes.contains(response.statusCode)) {
      throw ClientNetworkException();
    } else if (NetworkHelper.serverErrorCodes.contains(response.statusCode)) {
      throw ServerException();
    } else {
      throw GeneralException();
    }
  }
}
