class Quote {
  final String quoteContent;

  Quote({
    required this.quoteContent,
  });

  factory Quote.fromMap({required Map<String, dynamic> data, required e}) {
    return Quote(
      quoteContent: data['value'],
    );
  }

  factory Quote.fromDB({required Map<String, dynamic> data}) {
    return Quote(
      quoteContent: data['value'],
    );
  }

}