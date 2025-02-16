import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:rick_and_morty_practice/bloc/character_bloc.dart';
import 'package:rick_and_morty_practice/data/models/character.dart';
import 'package:rick_and_morty_practice/ui/widgets/custom_list_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  late Character _currentCharacter;
  List<Results> _currentResults = [];
  int _currentPage = 1;
  String _currentSearchQuery = '';
  bool _isPaginationEnabled = false;

  final refreshController = RefreshController();

  @override
  void initState() {
    if (_currentResults.isEmpty) {
      context.read<CharacterBloc>().add(CharacterFetchEvent(page: 1, name: ''));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            style: Theme.of(context).textTheme.bodyMedium,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Character name',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            onChanged: (value) {
              _currentPage = 1;
              _currentResults = [];
              _currentSearchQuery = value;

              context
                  .read<CharacterBloc>()
                  .add(CharacterFetchEvent(page: _currentPage, name: value));
            },
          ),
        ),
        Expanded(
          child: state.when(loading: () {
            if (_isPaginationEnabled) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }
            return _customListView(_currentResults);
          }, loaded: (characterLoaded) {
            _currentCharacter = characterLoaded;

            if (_isPaginationEnabled) {
              _currentResults.addAll(_currentCharacter.results);
              refreshController.loadComplete();
              _isPaginationEnabled = false;
            } else {
              _currentResults = List.of(characterLoaded.results);
            }

            return _currentResults.isNotEmpty
                ? _customListView(_currentResults)
                : Text("Nothing found");
          }, error: () {
            return Text("Something went wrong");
          }),
        ),
      ],
    );
  }

  Widget _customListView(List<Results> currentResults) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: () {
        _isPaginationEnabled = true;
        _currentPage++;

        if (_currentPage <= _currentCharacter.info.pages) {
          context.read<CharacterBloc>().add(CharacterFetchEvent(
              page: _currentPage, name: _currentSearchQuery));
        } else {
          refreshController.loadNoData();
        }
      },
      child: ListView.separated(
          separatorBuilder: (_, index) => SizedBox(
                height: 5,
              ),
          itemCount: currentResults.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final result = currentResults[index];

            return Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
                top: 5,
                bottom: 5,
              ),
              child: CustomListTile(
                result: result,
              ),
            );
          }),
    );
  }
}
