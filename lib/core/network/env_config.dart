class EnvConfig {
  static const String baseUrl = String.fromEnvironment(
    'baseUrl',
    defaultValue: 'https://dummyjson.com/',
  );
}
