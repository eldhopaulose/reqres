import 'package:flutter/material.dart';
import 'package:reqres/networks/dio/dio_client.dart';

enum EndPoints {
  login,
}

extension EndpointData on EndPoints {
  String path() {
    String path = "";
    switch (this) {
      case EndPoints.login:
        path = "api/login";
    }
    return path;
  }

  ReqType type() {
    ReqType type;
    switch (this) {
      case EndPoints.login:
        type = ReqType.POST;
    }
    return type;
  }
}
