import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogPage extends StatefulWidget {
  @override
  _DogPageState createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
  List<DogBreed> breeds = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://dogbreeddb.p.rapidapi.com/'),
      headers: {
        "X-RapidAPI-Key": "c3564955bfmsh215d19541e7ca79p11b5dfjsna3b5c6f6b0c8",
        "X-RapidAPI-Host": "dogbreeddb.p.rapidapi.com",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        breeds = data.map((json) => DogBreed.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Breeds'),
      ),
      body: ListView.builder(
        itemCount: breeds.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(breeds[index].breedName),
            subtitle: Text(breeds[index].breedType),
          );
        },
      ),
    );
  }
}

class DogBreed {
  final int id;
  final String breedName;
  final String breedType;
  final String breedDescription;

  DogBreed({
    required this.id,
    required this.breedName,
    required this.breedType,
    required this.breedDescription,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
      id: json['id'],
      breedName: json['breedName'],
      breedType: json['breedType'],
      breedDescription: json['breedDescription'],
    );
  }
}
