enum Kind {
  buy('buy'),
  sell('sell');

  final String value;

  const Kind(this.value);

  static Kind fromString(String value) {
    return Kind.values.firstWhere(
      (k) => k.value == value,
      orElse: () => throw ArgumentError('Invalid Kind: $value'),
    );
  }
}