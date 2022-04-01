import 'package:a14_pokedex_bloc/models/poke.dart';
import 'package:a14_pokedex_bloc/services/poke_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchPokeEvent {}

abstract class PokeState {}

class PokeInitialState extends PokeState {}

class PokeLoadingState extends PokeState {}

class PokeSuccessState extends PokeState {
  final List<Poke> pokeList;
  PokeSuccessState({required this.pokeList});
}

class PokemonErrorState extends PokeState {
  final String errorMessage;
  PokemonErrorState({required this.errorMessage});
}

class PokeBloc extends Bloc<FetchPokeEvent, PokeState> {
  PokeBloc() : super(PokeInitialState()) {
    on<FetchPokeEvent>((event, emit) async {
      emit(PokeLoadingState());
      try {
        final pokeList = await PokeService.fetchPokeList();
        emit(PokeSuccessState(pokeList: pokeList));
      } catch (e) {
        emit(PokemonErrorState(errorMessage: e.toString()));
      }
    });
  }
}
