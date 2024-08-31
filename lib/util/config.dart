class Config {
  static late final Config instance;

  final String kKeyCloakRealm;
  final String kRestApiBaseURL;

  Config._dev()
      : kKeyCloakRealm = 'auth/realms/REALM_NAME',
        kRestApiBaseURL = 'localhost:3946';

  Config._prod()
      : kKeyCloakRealm = 'auth/realms/REALM_NAME',
        kRestApiBaseURL = 'URL';

  factory Config(String? flavor) {
    if (flavor == 'dev') {
      instance = Config._dev();
    } else if (flavor == 'prod') {
      instance = Config._prod();
    } else {
      throw Exception("Unknown flaver : $flavor}");
    }

    return instance;
  }
}
