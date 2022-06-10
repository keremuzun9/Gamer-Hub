import 'package:flutter/material.dart';
import 'package:gamer_hub/drawer.dart';
import 'package:gamer_hub/models/api_acces.dart';
import 'package:gamer_hub/models/news_model.dart';
import 'package:gamer_hub/models/user_instance.dart';
import 'package:gamer_hub/news_search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsPage extends StatefulWidget {
  NewsPage({
    Key? key,
  }) : super(key: key);
  @override
  State<NewsPage> createState() => _NewsPageState();
}

final List<NewsModel> _postList = [];

class _NewsPageState extends State<NewsPage> {
  _NewsPageState();
  @override
  Widget build(BuildContext context) {
    getNews(UserInstance.userToken!);
    return Scaffold(
      drawer: MyDrawer(user: UserInstance.getUser()),
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
                    return NewsSearchPage();
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
            itemCount: _postList.length,
            itemBuilder: (context, index) {
              String? aNewsTitle = _postList.elementAt(index).title;
              String? aNewsContent = _postList.elementAt(index).content;
              String? aNewsImage = _postList.elementAt(index).image;
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
                          buildImage(aNewsImage!),
                          buildTitle(context, aNewsTitle!, aNewsContent!)
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
            Image.asset(
              'assets/images/person2.png',
              fit: BoxFit.scaleDown,
              color: Colors.white,
            ),
            Text(
              "Due to an error we couldn't display the image.",
              style: GoogleFonts.montserrat(color: Colors.white),
            )
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
      Uri.https(ApiAcces.baseUrl, "Api/Post"),
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
            setState(() {
              _postList.add(NewsModel.fromJson(map));
            });
          }
        }
      }
    }
  }
}
