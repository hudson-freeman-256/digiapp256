import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../models/animal_feeds.dart';
import '../models/rent.dart';
import '../services/auth_service.dart';

class HomeScreenProvider with ChangeNotifier {

  static final String bearerToken = AuthService.token;
  List<Rent> _rents = [];
  List<AnimalFeed> _animalFeeds = [];

  List<Rent> get rents => _rents;
  List<AnimalFeed> get animalFeeds => _animalFeeds;

  Future<List<Rent>> fetchHomeRents() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://digifarmer.agrosahas.co/farmerapp/public/api/v1/home/rent_services'),
        headers: {'Authorization': 'Bearer $bearerToken'},
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List list = result['data']["rent-vendor-services"];
        List<Rent> homeRents = list.map((model) => Rent.fromJson(model)).toList();
        notifyListeners();
        return homeRents;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }


  Future<void> fetchAnimalFeeds() async {
    try {
      final response = await http.get(
        Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/home/animal_feeds'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List list = result['data']["feeds"];

        _animalFeeds = list.map((model) => AnimalFeed.fromJson(model)).toList();
        notifyListeners();

        Timer.periodic(const Duration(minutes: 2), (timer) async {
          try {
            final response = await http.get(
              Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/home/animal_feeds'),
              headers: {
                'Authorization': 'Bearer $bearerToken',
              },
            );
            if (response.statusCode == 200) {
              final result = json.decode(response.body);
              List list = result['data']["feeds"];

              _animalFeeds = list.map((model) => AnimalFeed.fromJson(model)).toList();
              notifyListeners();
            }
          } catch (e) {
            print('Error while auto-updating file: $e');
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
