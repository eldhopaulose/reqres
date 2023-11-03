class UserTokenError {
  String? token;
  String? error;

  UserTokenError({this.token, this.error});

  UserTokenError.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['error'] = error;
    return data;
  }
}
