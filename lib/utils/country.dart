class CountryCode {
  final String code;
  final String flag;

  CountryCode({
    required this.code,
    required this.flag,
  });
}

List<CountryCode> codes = [
  CountryCode(
      code: "+91",
      flag: 'https://cdn-icons-png.flaticon.com/512/206/206606.png'),
  CountryCode(
      code: "+1",
      flag: 'https://cdn-icons-png.flaticon.com/512/555/555526.png'),
];
