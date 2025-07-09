import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      home: Movie(),
    );
  }
}

class Movie extends StatefulWidget {
  const Movie({super.key});

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  Map<String, dynamic>? movieData;

  @override
  void initState() {
    super.initState();
    fetchMovie();
  }

  Future<void> fetchMovie() async {
    final url = Uri.parse("https://flutterucinterviewtask.onrender.com/random");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print(decoded);

      setState(() {
        movieData = decoded;
      });
    } else {
      print("Fail to load movie");
    }
  }

  Widget build(BuildContext context) {
    List<String> genres = [];
    if (movieData != null && movieData!['Genre'] != null) {
      genres = movieData!['Genre']
          .toString()
          .split(',')
          .map((g) => g.trim())
          .toList();
    }
    String awards = movieData!['Awards'] ?? '';
    String shortAward = awards.contains('Oscars')
        ? awards.substring(0, awards.indexOf('Oscars') + 'Oscars'.length)
        : (awards.contains('.') ? awards.split('.').first : awards);

    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Center(
        child: SingleChildScrollView(
          child: movieData == null
              ? CircularProgressIndicator(color: Colors.white)
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFF1E201A),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movieData!['Title'] ?? 'Title not found',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(movieData!['Poster']),
                                fit: BoxFit.cover, // Gives a nice crop effect
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                movieData!['Year'].toString(),
                                style: TextStyle(
                                    color: Color(0xFFB4D188), fontSize: 18),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                movieData!['Runtime'].toString(),
                                style: TextStyle(
                                    color: Color(0xFFB4D188), fontSize: 18),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                movieData!['Rated'].toString(),
                                style: TextStyle(
                                    color: Color(0xFFB4D188), fontSize: 18),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: genres.map((genre) {
                              // Capitalize first letter if needed
                              String capitalized = genre.isNotEmpty
                                  ? genre[0].toUpperCase() + genre.substring(1)
                                  : "";

                              return Container(
                                margin: EdgeInsets.only(right: 8),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Color(0xFF384E14),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  capitalized,
                                  style: TextStyle(color: Color(0xFFD0EDA1)),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star_rate,
                                color: Color(0xFFB4D188),
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${movieData!['imdbRating'] ?? ""}/10',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '(${movieData!['imdbVotes'] ?? ""} votes)',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person_2,
                                size: 30,
                                color: Color(0xFFB4D188),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Director: ${movieData!['Director'] ?? ""}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.camera_roll_outlined,
                                color: Color(0xFFB4D188),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'Writers: ${movieData!['Writer'] ?? ""}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            movieData!['Plot'],
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.language,
                                      color: Color(0xFFB4D188), size: 30),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Language:',
                                          style: TextStyle(
                                            color: Color(0xFFB4D188),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          movieData!['Language'] ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.public,
                                      color: Color(0xFFB4D188), size: 30),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Country:',
                                          style: TextStyle(
                                            color: Color(0xFFB4D188),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          movieData!['Country'] ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: Color(0xFFB4D188),
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Awards:',
                                    style: TextStyle(
                                        color: Color(0xFFB4D188), fontSize: 15),
                                  ),
                                  Text(
                                    shortAward,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: fetchMovie,
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFB1D18A),
                        ),
                        child: Center(
                          child: Text(
                            'Shuffle',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
