class News {
  var status;
  var totalResults;
  List<Articles> articles=[];

  News({required this.status, required this.totalResults, required this.articles});

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
   String title='';
   String author='';
   String description='';
   var urlToImage;
   String publishedAt='';
   String content='';
   String articleUrl='';
   var source;
   var url;

  Articles(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.content, 
      required this.publishedAt, 
      required this.articleUrl,
      });

  Articles.fromJson(Map<String, dynamic> json) {
    source =json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'].toString();
    title = json['title'].toString();
    description = json['description'].toString();
    url = json['url'].toString();
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'].toString();
    content = json['content'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['author'] = this.author.toString();
    data['title'] = this.title.toString();
    data['description'] = this.description.toString();
    data['url'] = this.url.toString();
    data['urlToImage'] = this.urlToImage.toString();
    data['publishedAt'] = this.publishedAt.toString();
    data['content'] = this.content.toString();
    return data;
  }
}

class Source {
  String id='';
  String name='';

  Source({required this.id, required this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}