// ignore_for_file: constant_identifier_names

class EnvironmentConfig {
  static const CLIENT_ID = String.fromEnvironment(
    'CLIENT_ID',
    defaultValue: '',
  );
  static const PROJECT_ID = String.fromEnvironment(
    'PROJECT_ID',
    defaultValue: 'shiksha-dhra',
  );
  static const PROJECT_ENDPOINT = String.fromEnvironment(
    'PROJECT_ENDPOINT',
    defaultValue: 'http://localhost/v1',
  );
}
