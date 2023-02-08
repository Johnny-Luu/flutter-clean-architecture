import 'package:flutter_clean_architecture/domain/entities/entities.dart';

class TokenModel extends Token {
  const TokenModel({
    required String accessToken,
    required String refreshToken,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );

  Map<String, dynamic> toJson() => {
        'accesToken': accessToken,
        'refreshToken': refreshToken,
      };
}
