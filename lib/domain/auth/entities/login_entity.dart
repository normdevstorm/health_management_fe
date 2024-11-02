class LoginEntity {
  final String? accessToken;
  final String? refreshToken;

  LoginEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  LoginEntity copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return LoginEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
