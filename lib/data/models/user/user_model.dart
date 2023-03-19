import 'package:yaho_demo/domain/entities/user/page_info.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';

/// page : 1
/// per_page : 6
/// total : 12
/// total_pages : 2
/// data : [{"id":1,"email":"george.bluth@reqres.in","first_name":"George","last_name":"Bluth","avatar":"https://reqres.in/img/faces/1-image.jpg"},{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},{"id":3,"email":"emma.wong@reqres.in","first_name":"Emma","last_name":"Wong","avatar":"https://reqres.in/img/faces/3-image.jpg"},{"id":4,"email":"eve.holt@reqres.in","first_name":"Eve","last_name":"Holt","avatar":"https://reqres.in/img/faces/4-image.jpg"},{"id":5,"email":"charles.morris@reqres.in","first_name":"Charles","last_name":"Morris","avatar":"https://reqres.in/img/faces/5-image.jpg"},{"id":6,"email":"tracey.ramos@reqres.in","first_name":"Tracey","last_name":"Ramos","avatar":"https://reqres.in/img/faces/6-image.jpg"}]

class UserModel {
  UserModel({
    this.pageInfo,
    this.users,
  });

  UserModel.fromJson(dynamic json) {
    pageInfo = PageInfo.fromJson(json);
    if (json['data'] != null) {
      users = [];
      json['data'].forEach((v) {
        users?.add(User.fromJson(v));
      });
    }
  }
  PageInfo? pageInfo;
  List<User>? users;
  UserModel copyWith({
    PageInfo? pageInfo,
    List<User>? users,
  }) =>
      UserModel(
        pageInfo: pageInfo ?? this.pageInfo,
        users: users ?? this.users,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = pageInfo?.page;
    map['per_page'] = pageInfo?.perPage;
    map['total'] = pageInfo?.total;
    map['total_pages'] = pageInfo?.totalPages;
    if (users != null) {
      map['data'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
