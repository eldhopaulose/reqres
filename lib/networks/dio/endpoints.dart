import 'package:flutter/material.dart';
import 'package:reqres/networks/dio/dio_client.dart';

enum EndPoints {
  login,
  home,
}

extension EndpointData on EndPoints {
  String path() {
    String path = "";
    switch (this) {
      case EndPoints.login:
        path = "api/login";
      case EndPoints.home:
        path = "api/users?page=2";
    }
    return path;
  }

  ReqType type() {
    ReqType type;
    switch (this) {
      case EndPoints.login:
        type = ReqType.POST;
      case EndPoints.home:
        type = ReqType.GEt;
    }
    return type;
  }
}
