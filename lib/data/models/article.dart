import 'package:telex/data/models/author.dart';
import 'package:telex/data/models/tag.dart';

class Article {
  int id;
  String slug;
  String title;
  String image;
  String lead;
  DateTime date;
  List<Author> authors;
  Tag tag;

  Article(
    this.id,
    this.slug,
    this.title,
    this.image,
    this.lead,
    this.date,
    this.authors,
    this.tag,
  );

  factory Article.fromJson(Map json) {
    int id = json['id'];
    String slug = json['slug'];
    String title = json['title'];
    String image = json["imageSrc"];
    String lead = json["lead"];
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(json['pubDate'] * 1000).toLocal();
    Tag tag = Tag.fromJson(json['mainSuperTag']);
    List<Author> authors = [];
    json['authors'].forEach((a) => authors.add(Author.fromJson(a)));

    return Article(id, slug, title, image, lead, date, authors, tag);
  }
}
