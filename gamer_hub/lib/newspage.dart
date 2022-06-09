import 'package:flutter/material.dart';
import 'package:gamer_hub/drawer.dart';
import 'package:gamer_hub/models/news_model.dart';
import 'package:gamer_hub/models/user_model.dart';
import 'package:gamer_hub/news_search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> newsTitle = [];
List<String> newsContent = [];
List<String> newsImage = [];
List<int> newsId = [];
List<String> newsGameName = [];

class NewsPage extends StatefulWidget {
  UserModel user;
  NewsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState(user);
}

final List<NewsModel> _postList = [];

class _NewsPageState extends State<NewsPage> {
  UserModel user;
  _NewsPageState(this.user);
  @override
  Widget build(BuildContext context) {
    getNews(user.token);
    return Scaffold(
      drawer: MyDrawer(user: user),
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(
          "News & Upgrades",
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NewsSearchPage(user: user);
                  },
                ));
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: const Color(0xFF2E3239),
        centerTitle: true,
        elevation: 2.5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: newsTitle.length,
            itemBuilder: (context, index) {
              String aNewsTitle = newsTitle[index];
              String aNewsContent = newsContent[index];
              String aNewsImage = newsImage[index];
              return Card(
                color: const Color(0xFF2E3239),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.black)),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildImage(aNewsImage),
                          buildTitle(context, aNewsTitle, aNewsContent)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget buildImage(String url) {
    return FadeInImage(
      height: 400,
      image: NetworkImage(url),
      placeholder: const AssetImage("assets/gifs/loading.gif"),
      imageErrorBuilder: (context, error, stackTrace) {
        return Center(
          child: Column(children: [
            Image.asset('assets/images/person2.png', fit: BoxFit.scaleDown, color: Colors.white,),
            Text("Due to an error we couldn't display the image.", style: GoogleFonts.montserrat(color: Colors.white),)
          ]),
        );
      },
      fit: BoxFit.cover,
    );
  }

  Widget buildTitle(BuildContext context, String title, String content) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(16),
      iconColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(title,
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1)),
      ),
      children: [
        Text(content,
            style: GoogleFonts.montserrat(
              color: Colors.white,
            )),
      ],
    );
  }

  Future getNews(String token) async {
    var response = await http.get(
      Uri.https("1ce6-46-196-74-101.eu.ngrok.io", "Api/Post"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values;
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _postList.add(NewsModel.fromJson(map));
            debugPrint('${map['title']}');
            if (newsTitle.contains(map['title'])) {
              return null;
            } else {
              newsTitle.add(map['title']);
            }
            if (newsContent.contains(map['content'])) {
              return null;
            } else {
              newsContent.add(map['content']);
            }
            if (newsImage.contains(map['image'])) {
              return null;
            } else {
              newsImage.add(map['image']);
            }
            if (newsId.contains(map['postId'])) {
              return null;
            } else {
              newsId.add(map['postId']);
              //   }if (newsGameName.contains(map['gamename'])) {
              //     return null;
              //   } else {
              //     newsGameName.add(map['gamename']);
              // }
            }
          }
          debugPrint(newsTitle.toString());
        }
        setState(() {});
      }
    }
  }
}
