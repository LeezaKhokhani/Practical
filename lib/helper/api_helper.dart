import 'dart:convert';
import 'package:http/http.dart' as http;
import '../moduls/api_models.dart';

class QuoteAPIHelper {
  QuoteAPIHelper._();

  static final QuoteAPIHelper quoteAPIHelper = QuoteAPIHelper._();

  Future<Quote?> fetchQuoteData() async {
    String baseURL = "https://api.chucknorris.io/jokes/random";

    http.Response res = await http.get(Uri.parse(baseURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(res.body);

      Quote quote = Quote.fromMap(data: decodedData, e: null);

      print(decodedData);

      return quote;
    }
    return null;
  }
}