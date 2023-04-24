

// 登录请求
class UserLoginRequestEntity {
  String userName;
  String passWord;


  UserLoginRequestEntity({
    required this.userName,
    required this.passWord,

  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        userName: json["userName"],
        passWord: json["passWord"],

      );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "passWord": passWord,

  };
}

// 登录返回
class UserLoginResponseEntity {
  UserLoginResponseEntity({
    required this.token,
    required this.name,
    required this.staffId,
  });

  String token;
  String name;

  int staffId;

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) => UserLoginResponseEntity(
    token: json["token"],
    name: json["name"],
    staffId: json["staffId"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
    "staffId": staffId,
  };
}

class UserInfo {
  UserInfo({
    this.avatar,
    this.email,
    this.id,
    this.nickName,
    this.sex,
    this.type
  });

  String? avatar;
  String? email;
  String? id;
  String? nickName;
  String? sex;
  String? type;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    avatar: json["avatar"],
    email: json["email"],
    id: json["id"],
    nickName: json["nickName"],
    sex: json["sex"],
      type: json["type"]
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "email": email,
    "id": id,
    "nickName": nickName,
    "sex": sex,
    "type":type
  };
}


class UserListResponseEntity {
  String? total;
  List<UserInfo>? rows;

  UserListResponseEntity({
    this.total,
    this.rows,
  });

  factory UserListResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserListResponseEntity(
        total: json["total"],
        rows: json["rows"] == null
            ? []
            : List<UserInfo>.from(
            json["rows"].map((x) => UserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "total": total ?? "0",
    "rows": rows == null
        ? []
        : List<dynamic>.from(rows!.map((x) => x.toJson())),
  };
}

class PageRequest{
  int pageSize;
  int pageNum;
  dynamic params;

  PageRequest({
    required this.pageSize,
    required this.pageNum,
    this.params,
  });
  factory PageRequest.fromJson(Map<String, dynamic> json) => PageRequest(
      pageSize: json["pageSize"],
      pageNum: json["pageNum"],
      params: json["params"],
  );

  Map<String, dynamic> toJson() => {
    "pageSize": pageSize,
    "pageNum": pageNum,
    "params": params,
  };
}
