import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon.dart' as Pokedex;

Future<List<Pokedex.Pokemon>> fetchPokemon() async {
  String url = 'https://pokeapi.co/api/v2/pokemon/?limit=717';
  http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {
        'Accept': 'application/json'
      },
  );

  List parsed = json.decode(response.body)['results'];
  print(response.body);
  return parsed.map<Pokedex.Pokemon>((json) => Pokedex.Pokemon.fromJson(json)).toList();
}

List<Pokedex.Pokemon> parsePokemon(String responseBody) {
  List parsed = json.decode(responseBody)['results'];
  print(responseBody);
  return parsed.map<Pokedex.Pokemon>((json) => Pokedex.Pokemon.fromJson(json)).toList();
}

var client = new http.Client();

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new PokemonList(),
    );
  }
}

class PokemonList extends StatefulWidget {
  @override
  PokemonListState createState() => new PokemonListState();
}

class PokemonListState extends State<PokemonList> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return pokemonScaffold(context);
  }

  Widget pokemonScaffold(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('POKEDEX'),
      ),
      body: pokemons(context)
    );
  }
  
  Widget pokemons(BuildContext context) {
    return new FutureBuilder(
        future: fetchPokemon(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? pokemonListView(context, snapshot.data)
              : Center(child: CircularProgressIndicator());
        }
    );
  }

  Widget pokemonListView(BuildContext context, List<Pokedex.Pokemon> pokemon) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(pokemon.length, (index) {
        return new Center(
          child: pokemonListTile(pokemon[index].name, index),
        );
      }),
    );

//    return new ListView.builder(
//      padding: const EdgeInsets.all(16.0),
//      itemBuilder:
//        (BuildContext _context, int i) =>
//          pokemonListTile(pokemon[i].name),
//      itemCount: pokemon.length,
//    );

  }

  Widget pokemonListTile(String name, int index) {
    return new ListTile(
      title: Image.asset('images/${(index + 1)}.png', width: 100.0, height: 100.0,),
      subtitle:  Text(
        name,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        print('coolio');
      },
    );
  }
}