class NewsModel {
  String? sourceID;
  String? sourceName;
  String? author;
  String title; 
  String description;
  String url;
  String? urlToImage;
  String publishedAt;
  String content;
  
  NewsModel({
    this.sourceID,
    this.sourceName,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      sourceID: json['source']['id'].toString(),
      sourceName: json['source']['name'].toString(),
      author: json['author'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      url: json['url'].toString(),
      urlToImage: json['urlToImage'] ?? "https://play-lh.googleusercontent.com/8LYEbSl48gJoUVGDUyqO5A0xKlcbm2b39S32xvm_h-8BueclJnZlspfkZmrXNFX2XQ",
      publishedAt: json['publishedAt'].toString(),
      content: json['content'].toString(),
    );
  }
}
