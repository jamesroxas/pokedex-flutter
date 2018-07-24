import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/stats.dart';

class PokemonServices {
  Future<List<Pokemon>> fetchPokemonList() async {
    String url = 'https://pokeapi.co/api/v2/pokemon/';
    http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {
        'Accept': 'application/json'
      },
    );

    List parsed = json.decode(response.body)['results'];
    return parsed.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
  }

  Future<List<Stats>> fetchPokemonDetails(String url) async {
    http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {
        'Accept': 'application/json'
      },
    );

    List parsed = json.decode(response.body)['stats'];

    List<Stats> stats = parsed.map<Stats>((json) =>
        Stats.fromJson(json)).toList();

    return stats;
  }
}