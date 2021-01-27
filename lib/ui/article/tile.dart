import 'package:flutter/material.dart';
import 'package:telex/data/models/article.dart';
import 'package:telex/ext/timeago/messages/hu.dart';
import 'package:telex/ui/feed/tile.dart';
import 'package:telex/ui/image.dart';
import 'package:telex/ui/article/view.dart';
import 'package:telex/ui/dot.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleTile extends Tile {
  const ArticleTile({Key key, this.article, this.type}) : super(key: key);

  final Article article;
  final String type;

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages("hu", HuMessages());

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
          color: Color(0x12FFFFFF),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            highlightColor: Colors.transparent,
            child: Column(
              children: [
                (article.image ?? "") != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        child: Row(children: [
                          Expanded(
                              child: TelexImage(
                            article.image,
                            height: 200.0,
                            loadingBuilder: (context) =>
                                Container(height: 200.0),
                          ))
                        ]),
                      )
                    : Container(),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Text(article.title),
                  ),
                  subtitle: article.lead != null && article.lead != ""
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            article.lead,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : Container(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 14.0,
                    right: 14.0,
                    bottom: 12.0,
                  ),
                  child: Row(children: [
                    article.authors.length > 0
                        ? Padding(
                            padding: EdgeInsets.only(right: 6.0),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/profile.png',
                                width: 20.0,
                              ),
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: article.authors.length > 0
                          ? Text(
                              article.authors[0].name,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Container(),
                    ),
                    Text(
                      article.tag.name,
                      style: TextStyle(color: Color(0xFF00916B)),
                      softWrap: false,
                    ),
                    article.date != null ? Separator() : Container(),
                    article.date != null
                        ? Text(timeago.format(article.date, locale: 'hu'))
                        : Container(),
                  ]),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticleView(
                        article: article.slug,
                      )));
            },
          ),
        ),
      ),
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Dot(
          size: .2,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black26
              : Colors.white24),
    );
  }
}
