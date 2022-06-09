class NewsModel {
  int? postId;
  String? image;
  String? title;
  String? content;
  String? gamename;

NewsModel({this.postId, this.image, this.title, this.content, this.gamename});

NewsModel.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    image = json['image'];
    title = json['title'];
    content = json['content'];
    gamename = json['gamename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['postId'] = this.postId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['content'] = this.content;
    data['gamename'] = this.gamename;
    return data;
  }
}