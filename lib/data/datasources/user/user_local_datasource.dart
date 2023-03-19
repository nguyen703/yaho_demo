import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaho_demo/common/path_constants.dart';
import 'package:yaho_demo/core/error/exceptions.dart';
import 'package:yaho_demo/domain/entities/user/page_info.dart';

abstract class UserLocalDatasource {
  /// Uses SharedPreference to get current pagination data.
  ///
  /// Throws a [ParsingException] when getting errors parsing json.
  PageInfo getPaginationData();

  /// Saves pagination data to SharedPreference under json format
  ///
  /// Throws a [ParsingException] when getting errors parsing json.
  Future<void> savePaginationData(PageInfo pageInfo);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  UserLocalDatasourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  PageInfo getPaginationData() {
    final jsonString =
        sharedPreferences.getString(PathConstants.localUserPaginationPath);
    if (jsonString == null) throw ParsingException();
    try {
      return PageInfo.fromJson(json.decode(jsonString));
    } catch (_) {
      throw ParsingException();
    }
  }

  @override
  Future<void> savePaginationData(PageInfo pageInfo) async {
    await sharedPreferences.setString(
      PathConstants.localUserPaginationPath,
      json.encode(pageInfo.toJson()),
    );
  }
}
