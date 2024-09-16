part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchErrorState extends SearchState {}

final class SearchSuccessState extends SearchState {

}
