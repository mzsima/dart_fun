import 'package:a14_pokedex_bloc/bloc/poke_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokePage extends StatefulWidget {
  const PokePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PokePage> createState() => _PokePageState();
}

class _PokePageState extends State<PokePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokeBloc()..add(FetchPokeEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<PokeBloc, PokeState>(
          builder: (context, state) {
            if (state is PokeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PokemonErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            if (state is PokeSuccessState) {
              return ListView.builder(
                itemCount: state.pokeList.length,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  final poke = state.pokeList[index];
                  return ListTile(
                    contentPadding: EdgeInsets.only(left: 16),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        poke.img,
                      ),
                    ),
                    title: Text(poke.name),
                    subtitle: Text(poke.type),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
