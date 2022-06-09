import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamer_hub/models/news_model.dart';
import 'package:gamer_hub/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsSearchPage extends StatefulWidget {
  UserModel user;
  NewsSearchPage({Key? key, required this.user}) : super(key: key);

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState(user);
}

String? lastInputValue;
String? _gamename;

final List<NewsModel> _postList = [];

class _NewsSearchPageState extends State<NewsSearchPage> {
  UserModel user;
  _NewsSearchPageState(this.user);
  @override
  void initState() {
    _postList.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(
          "Search News",
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: const Color(0xFF2E3239),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        elevation: 2.5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade900,
                  child: Image.asset(
                    "assets/images/signin.png",
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
                child: SizedBox(
                  height: 50,
                  width: 340,
                  child: TextField(
                    autofocus: true,
                    cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          filled: true,
                          fillColor: const Color(0xFF2E3239),
                          hintText: "Search for a game or news.",
                          suffixIconColor: Colors.white,
                          suffixIcon: const Icon(Icons.search, color: Colors.white,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintStyle: const TextStyle()),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      style: GoogleFonts.montserrat(
                        color: Colors.white
                      ),
                      onSubmitted: (inputValue) {
                        _gamename = inputValue;
                        getNews(user.token);
                        setState(() {
                          _postList.clear();
                        });
                      }),
                ),
              )
            ],
          ),
          Flexible(
            child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: _postList.length,
                itemBuilder: (context, index) {
                  String? aNewsTitle = _postList.elementAt(index).title;
                  String? aNewsContent = _postList.elementAt(index).content;
                  String? aNewsImage = _postList.elementAt(index).image;
                  //debugPrint(_postList.length.toString());
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
        ],
      ),
    );
  }

  Widget buildImage(String url) {
    return FadeInImage(
      height: 450,
      image: NetworkImage(url),
      placeholder: const AssetImage(
        "assets/gifs/loading.gif",
      ),
      imageErrorBuilder: (context, error, stackTrace) {
        return Center(
          child: Column(children: [
            Image.asset('assets/images/person2.png', fit: BoxFit.scaleDown, color: Colors.white,),
            Text("Due to an error we couldn't display the image.", style: GoogleFonts.montserrat(color: Colors.white,))
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
    var body = {"searchstring": _gamename};
    var response = await http.post(
        Uri.https("1ce6-46-196-74-101.eu.ngrok.io", "Api/Post/Search"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(body));
    var data = response.body;
    debugPrint(data);
    if (data.isEmpty) {
      return null;
    } else {
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
          debugPrint(_postList.toString());
          //_postList.clear();
        }
      }
    }
  }
}
