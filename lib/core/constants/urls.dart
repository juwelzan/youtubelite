class Urls {
  Urls._();

  static final Uri home = Uri.parse("https://m.youtube.com");
  static final Uri shorts = Uri.parse("https://m.youtube.com/shorts");
  static final Uri subscribe = Uri.parse(
    'https://m.youtube.com/feed/subscriptions',
  );
  static final Uri you = Uri.parse('https://m.youtube.com/feed/library');
  static Uri search(String encoded) =>
      Uri.parse('https://m.youtube.com/results?search_query=$encoded');
}
