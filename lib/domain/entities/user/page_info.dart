/// page : 1
/// per_page : 6
/// total : 12
/// total_pages : 2

class PageInfo {
  PageInfo({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
  });

  PageInfo.fromJson(dynamic json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
  }
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  PageInfo copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
  }) =>
      PageInfo(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        totalPages: totalPages ?? this.totalPages,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['per_page'] = perPage;
    map['total'] = total;
    map['total_pages'] = totalPages;
    return map;
  }
}
