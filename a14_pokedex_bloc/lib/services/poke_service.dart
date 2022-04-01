import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a14_pokedex_bloc/models/poke.dart';

class PokeService {
  static Future<List<Poke>> fetchPokeList() async {
    try {
      final resp = await http.get(
        Uri.parse('https://jsonkeeper.com/b/GXGP'),
      );

      final Map<String, dynamic> decoded = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final pokeResp = PokeResponse.fromJson(decoded);
        return pokeResp.data;
      } else {
        throw Exception('Failed to load pokedex');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
